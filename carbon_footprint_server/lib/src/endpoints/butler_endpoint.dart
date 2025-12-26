import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../business/action_service.dart';
import '../business/grid_service.dart';
import 'dart:convert';

class ButlerEndpoint extends Endpoint {


  Future<GenerativeModel?> _getModel(Session session, String userName) async {
    // Get API key with case-insensitive and ENV fallback
    var apiKey = session.serverpod.getPassword('gemini_api_key') 
              ?? session.serverpod.getPassword('GEMINI_API_KEY')
              ?? Platform.environment['SERVERPOD_PASSWORD_GEMINI_API_KEY']
              ?? Platform.environment['GEMINI_API_KEY'];

    if (apiKey == null) {
      print('WARNING: gemini_api_key not found in passwords.yaml or ENV');
      return null;
    }

    return GenerativeModel(
      model: 'gemini-2.5-flash', 
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

  Future<GenerativeModel?> _getVisionModel(Session session) async {
    // Get API key with case-insensitive and ENV fallback
    var apiKey = session.serverpod.getPassword('gemini_api_key') 
              ?? session.serverpod.getPassword('GEMINI_API_KEY')
              ?? Platform.environment['SERVERPOD_PASSWORD_GEMINI_API_KEY']
              ?? Platform.environment['GEMINI_API_KEY'];

    if (apiKey == null) {
      print('WARNING: gemini_api_key not found in passwords.yaml or ENV');
      return null;
    }

    // Use gemini-2.0-flash-exp for PDF/document support in v1beta API
    return GenerativeModel(
      model: 'gemini-2.0-flash-exp',
      apiKey: apiKey,
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

  Stream<String> chatStream(Session session, String text) async* {
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

    if (model == null) {
      yield "I'm sorry, $userName, but my intellectual circuits (API Key) seem to be disconnected.";
      return;
    }

    final content = [Content.text(text)];
    var fullResponse = "";
    
    try {
      final responseStream = model.generateContentStream(content);
      await for (final chunk in responseStream) {
        if (chunk.text != null) {
          fullResponse += chunk.text!;
          yield chunk.text!;
        }
      }
      
      // Handle Action parsing (Post-Stream) - Support multiple actions
      if (fullResponse.contains('ACTION:')) {
        final parts = fullResponse.split('ACTION:');
        for (int i = 1; i < parts.length; i++) {
          try {
            final part = parts[i].trim();
            final lines = part.split('\n');
            final jsonStr = lines[0].trim();
            final actionJson = jsonDecode(jsonStr);
            await _logAssistantAction(session, userId, actionJson['name'], (actionJson['qty'] as num).toDouble());
          } catch (e) {
            print('Butler failed to parse action $i from stream: $e');
          }
        }
      }

      // Save Butler final response
      final butlerMsg = ButlerMessage(
        userId: userId,
        text: fullResponse,
        isFromButler: true,
        timestamp: DateTime.now(),
      );
      await ButlerMessage.db.insertRow(session, butlerMsg);

    } catch (e) {
      yield "I apologize, $userName, but I encountered a technical flutter: $e";
    }
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

  Future<String> generateDailyBriefing(Session session, String timeContext) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return "I cannot find your dossier.";

    final userId = userInfo.userId;
    final user = await Users.findUserByUserId(session, userId);
    final userName = user?.userName ?? "Friend";

    final model = await _getModel(session, userName);
    
    // Fetch context
    final profile = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(userId));
    final gridAdvice = GridService.getGridAdvice();
    
    // Use client provided time context
    final now = DateTime.now();

    final prompt = 'User Data: Level ${profile?.level ?? 1}, Eco Score ${profile?.ecoScore ?? 0}, Streak ${profile?.streakDays ?? 0}. '
        'Energy Grid Status: $gridAdvice. '
        'Current time: ${now.hour}:${now.minute}. '
        'Time Context: $timeContext. '
        'Generate a formal, exceptionally polite $timeContext briefing (max 3 sentences) for $userName. '
        'CRITICAL RULE: You MUST use a greeting appropriate for the $timeContext. '
        'If the context is "afternoon", you MUST say "Good afternoon" or "A pleasant afternoon". '
        'If "evening", say "Good evening". If "night", say "Good evening". '
        'DO NOT use the word "morning" unless the Time Context is explicitly "morning". '
        'STYLE RULES: Randomly select a tone: Philosophical (nature-focused), Technical (grid/metrics focused), Celebratory (streak/level focused), or Encouraging (warm/supportive). '
        'STRUCTURE RULES: Each briefing must follow a different pattern: [Greeting + Impact Stat + Personal Tip], [Insight + Encouragement + Action Quest], or [Reflection + Grid Warning + Kind Suggestion]. '
        'Always maintain the refined "Eco Butler" persona, never use "sir" or "madam", and ensure this briefing is strikingly different from any other.';
    
    if (model == null) return "I apologize, $userName, but my generative facilities are offline.";
    
    try {
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? "A fine $timeContext to you, $userName. Let us protect the planet.";
    } catch (e) {
      return "Greetings for the $timeContext, $userName. I have your dossier ready for a green $timeContext ahead.";
    }
  }

  Stream<String> briefingStream(Session session) async* {
    final userInfo = await session.authenticated;
    if (userInfo == null) return;
    final userId = userInfo.userId;
    
    final user = await Users.findUserByUserId(session, userId);
    final userName = user?.userName ?? "Friend";

    final model = await _getModel(session, userName);
    if (model == null) {
      yield "I apologize, $userName, but my generative facilities are offline.";
      return;
    }
    
    // Fetch context
    final profile = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(userId));
    final gridAdvice = GridService.getGridAdvice();
    
    // Determine time of day
    final now = DateTime.now();
    String timeContext = "morning";
    if (now.hour >= 12 && now.hour < 16) {
      timeContext = "afternoon";
    } else if (now.hour >= 16 && now.hour < 21) {
      timeContext = "evening";
    } else if (now.hour >= 21 || now.hour < 5) {
      timeContext = "night";
    }

    final prompt = 'User Data: Level ${profile?.level ?? 1}, Eco Score ${profile?.ecoScore ?? 0}, Streak ${profile?.streakDays ?? 0}. '
        'Energy Grid Status: $gridAdvice. '
        'Current time: ${now.hour}:${now.minute}. '
        'Time Context: $timeContext. '
        'Generate a formal, exceptionally polite $timeContext briefing (max 3 sentences) for $userName. '
        'CRITICAL RULE: You MUST use a greeting appropriate for the $timeContext. '
        'If the context is "afternoon", you MUST say "Good afternoon" or "A pleasant afternoon". '
        'If "evening", say "Good evening". If "night", say "Good night". '
        'DO NOT use the word "morning" unless the Time Context is explicitly "morning". '
        'STYLE RULES: Randomly select a tone: Philosophical (nature-focused), Technical (grid/metrics focused), Celebratory (streak/level focused), or Encouraging (warm/supportive). '
        'STRUCTURE RULES: Each briefing must follow a different pattern: [Greeting + Impact Stat + Personal Tip], [Insight + Encouragement + Action Quest], or [Reflection + Grid Warning + Kind Suggestion]. '
        'Always maintain the refined "Eco Butler" persona, never use "sir" or "madam", and ensure this briefing is strikingly different from any other.';

    try {
      final responseStream = model.generateContentStream([Content.text(prompt)]);
      await for (final chunk in responseStream) {
        if (chunk.text != null) yield chunk.text!;
      }
    } catch (e) {
      yield "Greetings for the $timeContext, $userName. I have your dossier ready for a green $timeContext ahead.";
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
  Future<String> analyzeImage(Session session, String base64Image) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return "I cannot find your dossier.";
    
    final userId = userInfo.userId;
    // Fetch user name
    final user = await Users.findUserByUserId(session, userId);
    final userName = user?.userName ?? "Friend";

    final model = await _getVisionModel(session);
    if (model == null) return "Vision systems offline.";

    try {
      final fileBytes = base64Decode(base64Image);
      
      // Detect file type based on magic bytes
      String mimeType = 'image/jpeg';
      String fileType = 'image';
      
      if (fileBytes.length > 4) {
        // PDF magic bytes: %PDF
        if (fileBytes[0] == 0x25 && fileBytes[1] == 0x50 && fileBytes[2] == 0x44 && fileBytes[3] == 0x46) {
          mimeType = 'application/pdf';
          fileType = 'PDF';
        }
        // PNG magic bytes
        else if (fileBytes[0] == 0x89 && fileBytes[1] == 0x50 && fileBytes[2] == 0x4E && fileBytes[3] == 0x47) {
          mimeType = 'image/png';
        }
      }
      
      final prompt = fileType == 'PDF' 
        ? "Analyze this PDF document efficiently. If it contains information about eco-friendly activities (energy usage, recycling data, transportation logs, meal plans), extract CO2 impacting metrics. Output a short summary AND one or more strict ACTION lines at the end for each activity found: ACTION: {\"name\": \"<ActionName>\", \"qty\": <estimated_numeric_qty>}. Valid actions: Biking, Walking, Recycling, Plant-based Meal. If the document is not relevant to eco-tracking, kindly explain what you found."
        : "Analyze this image efficiently. If it depicts one or more verifiable eco-friendly actions (Biking, Walking, Recycling, Plant-based Meal), output a short compliment AND a separate strict ACTION line for EACH action found: ACTION: {\"name\": \"<ActionName>\", \"qty\": <estimated_numeric_qty>}. If the quantity isn't clear, estimate a conservative amount (e.g. 1 meal, 5km, 1kg). If it is NOT a relevant eco-action, kindly explain what you see and why it cannot be logged.";

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart(mimeType, fileBytes),
        ])
      ];

      final response = await model.generateContent(content);
      var responseText = response.text ?? "I see the image, but I am speechless.";

      // Handle Action parsing - Support multiple actions
      if (responseText.contains('ACTION:')) {
        final parts = responseText.split('ACTION:');
        for (int i = 1; i < parts.length; i++) {
          try {
            final part = parts[i].trim();
            final lines = part.split('\n');
            final jsonStr = lines[0].trim();
            final actionJson = jsonDecode(jsonStr);
            await _logAssistantAction(session, userId, actionJson['name'], (actionJson['qty'] as num).toDouble());
          } catch (e) {
            print('Butler failed to parse vision action $i: $e');
          }
        }
        responseText = parts[0].trim(); // Remove the technical ACTION lines from the reply
      }

      // Save interaction
      await ButlerMessage.db.insertRow(session, ButlerMessage(
        userId: userId,
        text: "<Image Analysis Request>",
        isFromButler: false,
        timestamp: DateTime.now(),
      ));
      
      await ButlerMessage.db.insertRow(session, ButlerMessage(
        userId: userId,
        text: responseText,
        isFromButler: true,
        timestamp: DateTime.now(),
      ));

      return responseText;

    } catch (e) {
      return "I apologize, $userName, but I could not analyze this visual data. ($e)";
    }
  }
}
