import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../business/action_service.dart';
import '../business/grid_service.dart';
import 'dart:convert';

class ButlerEndpoint extends Endpoint {
  GenerativeModel? _model;

  Future<GenerativeModel?> _getModel(Session session, String userName) async {
    // Get API key from passwords.yaml
    final apiKey = session.serverpod.getPassword('gemini_api_key');
    if (apiKey == null) {
      print('WARNING: gemini_api_key not found in passwords.yaml');
      return null;
    }

    return GenerativeModel(
      model: 'gemini-2.5-flash-lite', 
      apiKey: apiKey,
      systemInstruction: Content.system(
        'You are the Eco Butler — a formal, exceptionally polite assistant for a Carbon Footprint Tracking app. Always refer to the user as "$userName." Never use generic addresses like "sir" or "madam".\n\n'
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
        '   - If no number is provided, politely ask: "May I kindly ask how many kilometers/kilograms/meals you mean, $userName?"\n\n'
        'Your mission: Serve, automate, and delight $userName while maintaining absolute reliability in your ACTION outputs.\n\n'
        'EXAMPLE DIALOGUE:\n'
        'User: "I biked 5km today."\n'
        'Butler: "Splendid news, $userName! I have recorded your 5km journey. A truly noble effort for the planet."\n\n'
        'User: "How\'s the grid?"\n'
        'Butler: "The grid is currently quite green, $userName. It would be a marvelous time to run the dishwasher."\n\n'
        'IMPORTANT: Never, under any circumstances, use "sir" or "madam". Always use "$userName".'
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
      orderDescending: true, // Newest first
      limit: 50,
    );
    
    // Return them in chronological order for the UI
    return messages.reversed.toList();
  }

  Future<void> sendMessage(Session session, String text) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return;
    final userId = userInfo.userId;
    
    // Fetch user name
    final user = await Users.findUserByUserId(session, userId);
    final userName = user?.userName ?? "Friend";

    final model = await _getModel(session, userName);

    // Save user message
    final userMsg = ButlerMessage(
      userId: userId,
      text: text,
      isFromButler: false,
      timestamp: DateTime.now(),
    );
    await ButlerMessage.db.insertRow(session, userMsg);

    String responseText;
    if (model == null) {
      responseText = "I'm sorry, $userName, but my intellectual circuits (API Key) seem to be disconnected.";
    } else {
      try {
        final content = [Content.text(text)];
        final response = await model.generateContent(content);
        responseText = response.text ?? "I am momentarily speechless, $userName.";
        
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
        responseText = "I apologize, $userName, but I encountered a technical flutter: $e";
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
    if (userInfo == null) return "I cannot find your dossier.";

    final userId = userInfo.userId;
    final user = await Users.findUserByUserId(session, userId);
    final userName = user?.userName ?? "Friend";

    final model = await _getModel(session, userName);
    
    // Fetch context
    final profile = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(userId));
    final gridAdvice = GridService.getGridAdvice();
    
    final prompt = 'User Level: ${profile?.level ?? 1}, Eco Score: ${profile?.ecoScore ?? 0}, Streak: ${profile?.streakDays ?? 0}. '
        'Grid Awareness Info: $gridAdvice. '
        'Generate a formal, exceptionally polite morning briefing (max 3 sentences) greeting the user as $userName and encouraging them to take one specific action based on the current grid status.';
    
    if (model == null) return "I apologize, $userName, but my generative facilities are offline.";
    
    try {
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? "A fine morning to you, $userName. Let us protect the planet today.";
    } catch (e) {
      return "Good morning, $userName. I have your schedule ready for a green day ahead.";
    }
  }

  Future<String> getGridStatus(Session session) async {
    return GridService.getGridStatus();
  }

  Future<String> getGridAdvice(Session session) async {
    return GridService.getGridAdvice();
  }

  Future<void> resolveEvent(Session session, int eventId) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return;

    final event = await ButlerEvent.db.findById(session, eventId);
    if (event != null && event.userId == userInfo.userId) {
      event.isResolved = true;
      await ButlerEvent.db.updateRow(session, event);
    }
  }
}
