import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';

class ActionService {
  static Future<void> logAction(Session session, int userId, ActionLog log) async {
    log.userId = userId;
    await ActionLog.db.insertRow(session, log);

    // 1. Update User Profile (Eco Score, Level, Streak)
    var profile = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(userId));
    if (profile == null) {
      profile = UserProfile(userId: userId, ecoScore: 0, joinedDate: DateTime.now(), level: 1, streakDays: 0);
      await UserProfile.db.insertRow(session, profile);
    }

    // Calculate Streak
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (profile.lastActionDate != null) {
      final lastDate = DateTime(profile.lastActionDate!.year, profile.lastActionDate!.month, profile.lastActionDate!.day);
      final diff = today.difference(lastDate).inDays;
      if (diff == 1) {
        profile.streakDays += 1;
      } else if (diff > 1) {
        profile.streakDays = 1;
      }
    } else {
      profile.streakDays = 1;
    }
    profile.lastActionDate = now;

    // Update Score & Level
    profile.ecoScore += (log.co2Saved * 10).toInt();
    profile.level = (profile.ecoScore / 1000).toInt() + 1;
    
    await UserProfile.db.updateRow(session, profile);

    // 2. Social Post
    final action = await EcoAction.db.findById(session, log.actionId);
    final user = await Users.findUserByUserId(session, userId);
    
    await SocialPost.db.insertRow(session, SocialPost(
      userId: userId,
      userName: user?.userName,
      content: 'just logged ${log.quantity}${action?.unit ?? ""} of ${action?.name ?? "an action"}!',
      timestamp: now,
      type: 'action_logged'
    ));

    // 3. Check for Badges (e.g., Green Traveler for 10 transport actions)
    if (action != null) {
      final categoryCount = await ActionLog.db.count(session, where: (t) => t.userId.equals(userId) & t.action.category.equals(action.category));
      
      String? badgeName;
      String? badgeDesc;
      String? iconType;

      if (action.category == 'Transport' && categoryCount == 10) {
        badgeName = 'Solar King';
        badgeDesc = 'Logged 10 transport-related actions!';
        iconType = 'solar';
      } else if (action.category == 'Waste' && categoryCount == 5) {
        badgeName = 'Recycle Knight';
        badgeDesc = 'Logged 5 waste-related actions!';
        iconType = 'recycle';
      } else if (profile.level == 5 && profile.ecoScore >= 4000) {
          // Check if already earned to prevent duplicates
          final hasBadge = await Badge.db.findFirstRow(session, where: (t) => t.userId.equals(userId) & t.name.equals('Earth Guardian'));
          if (hasBadge == null) {
            badgeName = 'Earth Guardian';
            badgeDesc = 'Reached Level 5 and protected the planet!';
            iconType = 'earth';
          }
      }

      if (badgeName != null) {
        // Double check for duplicate before insert
        final existing = await Badge.db.findFirstRow(session, where: (t) => t.userId.equals(userId) & t.name.equals(badgeName!));
        if (existing == null) {
          await Badge.db.insertRow(session, Badge(
            userId: userId,
            name: badgeName,
            description: badgeDesc!,
            earnedDate: now,
            iconType: iconType,
          ));

          // Trigger Butler Celebration Event
          await ButlerEvent.db.insertRow(session, ButlerEvent(
            userId: userId,
            type: 'celebration',
            message: 'Congratulations, sir/madam! You have earned the "$badgeName" honor. A truly noble achievement!',
            timestamp: now,
            isResolved: false,
          ));
        }
      }

      // Check for "Budget Master" (Monthly savings relative to budget)
      final monthAgo = DateTime.now().subtract(const Duration(days: 30));
      final monthlyLogs = await ActionLog.db.find(session, where: (t) => t.userId.equals(userId) & (t.date > monthAgo));
      double monthlyTotalSaved = 0;
      for (var l in monthlyLogs) {
        monthlyTotalSaved += l.co2Saved;
      }

      if (monthlyTotalSaved >= (profile.monthlyBudget * 0.5)) {
        final existingBudgetBadge = await Badge.db.findFirstRow(session, where: (t) => t.userId.equals(userId) & t.name.equals('Budget Master'));
        if (existingBudgetBadge == null) {
          await Badge.db.insertRow(session, Badge(
            userId: userId,
            name: 'Budget Master',
            description: 'Saved more than 50% of your established budget this month!',
            earnedDate: now,
            iconType: 'budget',
          ));

          await ButlerEvent.db.insertRow(session, ButlerEvent(
            userId: userId,
            type: 'celebration',
            message: 'An exemplary performance, sir/madam! You have mitigated over half of your monthly footprint. You are a true "Budget Master"!',
            timestamp: now,
            isResolved: false,
          ));
        }
      }
    }
  }
}
