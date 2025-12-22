import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import 'dart:math';

class SeedEndpoint extends Endpoint {
  Future<String> seedData(Session session) async {
    final userInfo = await session.authenticated;
    print('DEBUG: seedData triggered. Authenticated User: ${userInfo?.userId}');

    try {
      // 1. Seed Actions (Incremental)
      final existingActions = await EcoAction.db.find(session);
      final existingNames = existingActions.map((a) => a.name).toSet();

      if (!existingNames.contains('Biking')) {
        await EcoAction.db.insertRow(session, EcoAction(name: 'Biking', co2Factor: 0.5, unit: 'km', category: 'Transport'));
      }
      if (!existingNames.contains('Walking')) {
        await EcoAction.db.insertRow(session, EcoAction(name: 'Walking', co2Factor: 0.1, unit: 'km', category: 'Transport'));
      }
      if (!existingNames.contains('Recycling')) {
        await EcoAction.db.insertRow(session, EcoAction(name: 'Recycling', co2Factor: 0.2, unit: 'kg', category: 'Waste'));
      }
      if (!existingNames.contains('Plant-based Meal')) {
        await EcoAction.db.insertRow(session, EcoAction(name: 'Plant-based Meal', co2Factor: 1.5, unit: 'meal', category: 'Food'));
      }
      
      final actions = await EcoAction.db.find(session);

      // 2. Seed Challenges
      final challenges = await Challenge.db.find(session);
      if (challenges.isEmpty) {
        final biking = actions.firstWhere((a) => a.name == 'Biking');
        final meal = actions.firstWhere((a) => a.name == 'Plant-based Meal');
        
        await Challenge.db.insertRow(session, Challenge(
          title: 'Bike to Work', description: 'Ride 20km this week', targetActionId: biking.id!, targetAmount: 20, unit: 'km', points: 100, durationDays: 7
        ));
        await Challenge.db.insertRow(session, Challenge(
          title: 'Green Eater', description: 'Eat 5 plant-based meals', targetActionId: meal.id!, targetAmount: 5, unit: 'meals', points: 50, durationDays: 7
        ));
      }

      // 3. Seed Mock User Profiles (Mocks 2, 3, 4)
      for (int i = 2; i <= 4; i++) {
        final existing = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(i));
        if (existing == null) {
          await UserProfile.db.insertRow(session, UserProfile(
            userId: i, 
            ecoScore: (i * 500) + 100, 
            joinedDate: DateTime.now().subtract(Duration(days: i * 10))
          ));
        }
      }

      // 4. Ensure current user has a profile
      if (userInfo != null) {
        final profile = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(userInfo.userId));
        if (profile == null) {
          await UserProfile.db.insertRow(session, UserProfile(
            userId: userInfo.userId,
            ecoScore: 0,
            joinedDate: DateTime.now(),
          ));
        }
      }

      // 5. Seed Butler Suggestion (If no active suggestion exists)
      if (userInfo != null) {
        final existingSuggestion = await ButlerEvent.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(userInfo.userId) & t.isResolved.equals(false),
        );
        if (existingSuggestion == null) {
          final user = await Users.findUserByUserId(session, userInfo.userId);
          final userName = user?.userName ?? "Friend";
          
          final suggestions = [
            'I noticed the morning air is exceptionally clear today, $userName. A brief walking meditation might be in order?',
            'The digital grid is flowing with renewable energy at this hour, $userName. Shall we capitalize on this for your tasks?',
            'Your current sustainability streak is most impressive, $userName. I have identified a new biking route that might interest you.',
            'A fine morning to you, $userName. The urban garden could benefit from our attention today—perhaps a recycling audit?',
          ];
          final randomMsg = suggestions[Random().nextInt(suggestions.length)];
          
          await ButlerEvent.db.insertRow(session, ButlerEvent(
            userId: userInfo.userId,
            type: 'suggestion',
            message: randomMsg,
            timestamp: DateTime.now(),
            isResolved: false,
          ));
        }
      }

      // 6. Seed Community Groups
      final existingGroups = await CommunityGroup.db.find(session);
      if (existingGroups.isEmpty) {
        await CommunityGroup.db.insertRow(session, CommunityGroup(
          name: 'Urban Cyclists',
          description: 'A group for city dwellers who prefer two wheels over four.',
          memberCount: 42,
          totalImpact: 1250.5,
        ));
        await CommunityGroup.db.insertRow(session, CommunityGroup(
          name: 'Zero Waste Warriors',
          description: 'Committed to reducing landfill waste, one jar at a time.',
          memberCount: 89,
          totalImpact: 540.2,
        ));
        await CommunityGroup.db.insertRow(session, CommunityGroup(
          name: 'Green Chefs',
          description: 'Exploring the delicious world of plant-based cuisine.',
          memberCount: 156,
          totalImpact: 2100.8,
        ));
      }

      // Add more diversity to challenges
      if (challenges.length < 4) {
        final recycle = actions.firstWhere((a) => a.name == 'Recycling');
        await Challenge.db.insertRow(session, Challenge(
          title: 'Recycle King', description: 'Recycle 10kg of waste', targetActionId: recycle.id!, targetAmount: 10, unit: 'kg', points: 150, durationDays: 30
        ));
        await Challenge.db.insertRow(session, Challenge(
          title: 'Marathon Walker', description: 'Walk 42km this month', targetActionId: actions.firstWhere((a) => a.name == 'Walking').id!, targetAmount: 42, unit: 'km', points: 300, durationDays: 30
        ));
      }

      // 7. Deep Clean: Update existing "sir/madam" references in database
      if (userInfo != null) {
        final profile = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(userInfo.userId));
        final user = await Users.findUserByUserId(session, userInfo.userId);
        final userName = user?.userName ?? "Friend";

        // Update existing ButlerEvents
        final events = await ButlerEvent.db.find(session, where: (t) => t.userId.equals(userInfo.userId));
        for (var event in events) {
          if (event.message.contains('sir') || event.message.contains('madam')) {
            event.message = event.message
              .replaceAll('sir/madam', userName)
              .replaceAll('madam/sir', userName)
              .replaceAll('sir', userName)
              .replaceAll('madam', userName);
            await ButlerEvent.db.updateRow(session, event);
          }
        }

        // Update existing ButlerMessages
        final messages = await ButlerMessage.db.find(session, where: (t) => t.userId.equals(userInfo.userId));
        for (var msg in messages) {
          if (msg.text.contains('sir') || msg.text.contains('madam')) {
            msg.text = msg.text
              .replaceAll('sir/madam', userName)
              .replaceAll('madam/sir', userName)
              .replaceAll('sir', userName)
              .replaceAll('madam', userName);
            await ButlerMessage.db.updateRow(session, msg);
          }
        }
      }

      return 'Seeding successful! Butler is ready to serve, and the database has been personalized for $userInfo.';
    } catch (e) {
      print('ERROR in seedData: $e');
      return 'Error seeding data: $e';
    }
  }
}
