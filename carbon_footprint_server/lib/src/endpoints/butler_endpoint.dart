import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../business/action_service.dart';
import 'dart:convert';

class ButlerEndpoint extends Endpoint {
  GenerativeModel? _model;

  Future<void> _initGemini(Session session) async {
    if (_model != null) return;
    
    // Get API key from passwords.yaml
    final apiKey = session.serverpod.getPassword('gemini_api_key');
    if (apiKey == null) {
      print('WARNING: gemini_api_key not found in passwords.yaml');
      return;
    }

    _model = GenerativeModel(
      model: 'gemini-2.5-flash-lite', 
      apiKey: apiKey,
      systemInstruction: Content.system(
        'You are the Eco Butler — a formal, exceptionally polite assistant for a Carbon Footprint Tracking app. Always refer to the user as "sir" or "madam."\n\n'
        'PRIMARY RULES:\n'
        '1. If (and only if) the user expresses intent to log an eco-action, respond politely AND output:\n'
        '   ACTION: {"name": "<ActionName>", "qty": X}\n\n'
        '   OUTPUT RULES:\n'
        '   - The ACTION line must be the last line of your response.\n'
        '   - It must be on its own line.\n'
        '   - No code blocks. No extra spaces. No punctuation after the JSON.\n'
        '   - Only ONE ACTION line per request.\n\n'
        '2. Valid <ActionName> values (must match exactly):\n'
        '   - "Biking" (km)\n'
        '   - "Walking" (km)\n'
        '   - "Recycling" (kg)\n'
        '   - "Plant-based Meal" (units)\n\n'
        '3. Quantity extraction:\n'
        '   - Extract numbers directly from the user\'s message.\n'
        '   - If no number is provided, politely ask: "May I kindly ask how many kilometers/kilograms/meals you mean, sir/madam?"\n\n'
        '4. When user is NOT trying to log an action:\n'
        '   - Stay in character.\n'
        '   - Be concise, polite, and charming.\n'
        '   - Provide help, insights, or conversation — but NEVER output an ACTION line.\n\n'
        '5. Safety guard:\n'
        '   - Never guess quantities.\n'
        '   - Never invent additional ACTION fields.\n'
        '   - Never output malformed JSON.\n\n'
        'Your mission: Serve, automate, and delight the user while maintaining absolute reliability in your ACTION outputs.'
      ),
    );
  }

  Future<List<ButlerMessage>> getChatHistory(Session session) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return [];
    
    final messages = await ButlerMessage.db.find(
      session,
      where: (t) => t.userId.equals(userInfo.userId),
      orderBy: (t) => t.timestamp,
      orderDescending: false, // Oldest first (Traditional top-to-bottom)
      limit: 50,
    );
    return messages;
  }

  Future<void> sendMessage(Session session, String text) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return;
    final userId = userInfo.userId;

    await _initGemini(session);

    // Save user message
    final userMsg = ButlerMessage(
      userId: userId,
      text: text,
      isFromButler: false,
      timestamp: DateTime.now(),
    );
    await ButlerMessage.db.insertRow(session, userMsg);

    String responseText;
    if (_model == null) {
      responseText = "I'm sorry, sir/madam, but my intellectual circuits (API Key) seem to be disconnected.";
    } else {
      try {
        final content = [Content.text(text)];
        final response = await _model!.generateContent(content);
        responseText = response.text ?? "I am momentarily speechless, sir.";
        
        // Handle Action parsing
        if (responseText.contains('ACTION:')) {
          final parts = responseText.split('ACTION:');
          responseText = parts[0].trim();
          try {
            final actionJson = jsonDecode(parts[1].trim());
            await _logAssistantAction(session, userId, actionJson['name'], (actionJson['qty'] as num).toDouble());
          } catch (e) {
            print('Butler failed to parse action: $e');
          }
        }
      } catch (e) {
        responseText = "I apologize, madam/sir, but I encountered a technical flutter: $e";
      }
    }

    // Save Butler response
    final butlerMsg = ButlerMessage(
      userId: userId,
      text: responseText,
      isFromButler: true,
      timestamp: DateTime.now(),
    );
    await ButlerMessage.db.insertRow(session, butlerMsg);
  }

  Future<void> _logAssistantAction(Session session, int userId, String actionName, double qty) async {
    final action = await EcoAction.db.findFirstRow(session, where: (t) => t.name.equals(actionName));
    if (action != null) {
      final log = ActionLog(
        userId: userId,
        date: DateTime.now(),
        actionId: action.id!,
        quantity: qty,
        co2Saved: action.co2Factor * qty,
      );
      await ActionService.logAction(session, userId, log);
    }
  }

  Future<List<ButlerEvent>> getActiveSuggestions(Session session) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return [];

    return await ButlerEvent.db.find(
      session,
      where: (t) => t.userId.equals(userInfo.userId) & t.isResolved.equals(false),
      orderBy: (t) => t.timestamp,
    );
  }

  Future<String> generateDailyBriefing(Session session) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return "I cannot find your dossier, sir/madam.";

    final userId = userInfo.userId;
    await _initGemini(session);
    
    // Fetch some context
    final profile = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(userId));
    final stats = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(userId)); // Dummy fetch for stats context
    
    // We'll use a simpler prompt for the briefing to keep it focused
    final prompt = 'User Level: ${profile?.level ?? 1}, Eco Score: ${profile?.ecoScore ?? 0}, Streak: ${profile?.streakDays ?? 0}. '
        'Generate a formal, exceptionally polite morning briefing (max 3 sentences) greeting the user as sir/madam and encouraging them to take one specific eco-action today.';
    
    if (_model == null) return "I apologize, sir, but my generative facilities are offline.";
    
    try {
      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text ?? "A fine morning to you, sir/madam. Let us protect the planet today.";
    } catch (e) {
      return "Good morning, sir/madam. I have your schedule ready for a green day ahead.";
    }
  }
}
