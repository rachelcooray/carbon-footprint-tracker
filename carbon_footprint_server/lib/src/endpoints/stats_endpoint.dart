import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../business/projection_service.dart';

class StatsEndpoint extends Endpoint {
  Future<UserStats> getUserStats(Session session, int dummyId) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) {
      return UserStats(
        totalCo2Saved: 0,
        weeklyCo2Saved: 0,
        ecoScore: 0,
        level: 1,
        streakDays: 0,
        monthlyBudget: 200.0,
        monthlyCo2Saved: 0,
      );
    }
    final userId = userInfo.userId;

    // Fetch user name to sync with profile
    final user = await Users.findUserByUserId(session, userId);
    final userName = user?.userName;

    var profile = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(userId));
    if (profile != null) {
      if (profile.userName == null && userName != null) {
        profile.userName = userName;
        await UserProfile.db.updateRow(session, profile);
      }
    }

    var logs = await ActionLog.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    double totalCo2 = 0;
    double weeklyCo2 = 0;
    double monthlyCo2Saved = 0;
    var now = DateTime.now();
    var weekAgo = now.subtract(const Duration(days: 7));
    var monthAgo = now.subtract(const Duration(days: 30));

    for (var log in logs) {
      totalCo2 += log.co2Saved;
      if (log.date.isAfter(weekAgo)) {
        weeklyCo2 += log.co2Saved;
      }
      if (log.date.isAfter(monthAgo)) {
        monthlyCo2Saved += log.co2Saved;
      }
    }

    // Use ecoScore from profile if available, else calculate from logs
    int ecoScore = profile?.ecoScore ?? (totalCo2 * 10).toInt();

    return UserStats(
      totalCo2Saved: totalCo2,
      weeklyCo2Saved: weeklyCo2,
      ecoScore: ecoScore,
      level: profile?.level ?? 1,
      streakDays: profile?.streakDays ?? 0,
      monthlyBudget: profile?.monthlyBudget ?? 200.0,
      monthlyCo2Saved: monthlyCo2Saved,
    );
  }

  Future<List<UserProfile>> getLeaderboard(Session session) async {
    final results = await UserProfile.db.find(
      session,
      orderBy: (t) => t.ecoScore,
      orderDescending: true,
      limit: 10,
    );
    
    // Ensure all entries have usernames if possible
    for (var profile in results) {
      if (profile.userName == null || profile.userName!.startsWith('User #')) {
        final user = await Users.findUserByUserId(session, profile.userId);
        if (user != null && user.userName != null) {
          profile.userName = user.userName;
          await UserProfile.db.updateRow(session, profile);
        }
      }
    }
    
    return results;
  }

  Future<List<Badge>> getBadges(Session session) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return [];
    
    return await Badge.db.find(
      session,
      where: (t) => t.userId.equals(userInfo.userId),
      orderBy: (t) => t.earnedDate,
      orderDescending: true,
    );
  }

  Future<void> updateMonthlyBudget(Session session, double budget) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return;
    final userId = userInfo.userId;

    // Fetch user name to store in profile
    final user = await Users.findUserByUserId(session, userId);
    final userName = user?.userName ?? "Friend";

    final profile = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(userId));
    if (profile != null) {
      profile.monthlyBudget = budget;
      profile.userName = userName; // Update name
      await UserProfile.db.updateRow(session, profile);
    } else {
      // Create profile if it doesn't exist
      await UserProfile.db.insertRow(session, UserProfile(
        userId: userId,
        ecoScore: 0,
        joinedDate: DateTime.now(),
        level: 1,
        streakDays: 0,
        monthlyBudget: budget,
        userName: userName, // Set name
      ));
    }

    // Award "Strategist" badge for setting a baseline
    final existingBadge = await Badge.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.name.equals('Strategist'),
    );
    if (existingBadge == null) {
      await Badge.db.insertRow(session, Badge(
        userId: userId,
        name: 'Strategist',
        description: 'Set a baseline for a noble green journey.',
        earnedDate: DateTime.now(),
        iconType: 'strategy',
      ));

      final user = await Users.findUserByUserId(session, userId);
      final userName = user?.userName ?? "Friend";
      await ButlerEvent.db.insertRow(session, ButlerEvent(
        userId: userId,
        type: 'celebration',
        message: 'Magnificent, $userName! You have established a strategic baseline for our mission. The "Strategist" honor is yours!',
        timestamp: DateTime.now(),
        isResolved: false,
      ));
    }
  }

  Future<Ecotrajectory> getEcotrajectory(Session session) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) {
      return Ecotrajectory(
        netZeroDate: DateTime.now().add(const Duration(days: 3650)),
        savingsRate: 0,
        isAchievable: false,
        daysToNetZero: 3650,
        currentCarbonDebt: 2400.0,
      );
    }
    return await ProjectionService.calculateTrajectory(session, userInfo.userId);
  }
}
