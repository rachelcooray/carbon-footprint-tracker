import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../business/grid_service.dart';

/// A future call that performs a proactive audit of user performance at midnight.
/// It analyzes daily logs and creates a personalized ButlerEvent suggestion.
class MidnightAudit extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    session.log('Starting Midnight Audit...', level: LogLevel.info);

    // 1. Fetch all user profiles
    final profiles = await UserProfile.db.find(session);

    for (var profile in profiles) {
      final userId = profile.userId;

      // 2. Fetch logs for the last 24 hours
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final logs = await ActionLog.db.find(
        session,
        where: (t) => t.userId.equals(userId) & (t.date > yesterday),
      );

      double totalSaved = 0;
      Map<int, double> categoryImpact = {}; // ActionId -> Savings

      for (var log in logs) {
        totalSaved += log.co2Saved;
        categoryImpact[log.actionId] = (categoryImpact[log.actionId] ?? 0) + log.co2Saved;
      }

      // 3. Generate Butler Verdict
      final user = await Users.findUserByUserId(session, userId);
      final userName = user?.userName ?? "Friend";

      String verdict;
      if (logs.isEmpty) {
        verdict = 'I noticed a lack of activity yesterday. Shall I prepare a walking route for today?';
      } else if (totalSaved < 2.0) {
        verdict = 'A modest start. The grid is ${GridService.getGridStatus().toLowerCase()}—shall we run high-energy tasks now?';
      } else {
        verdict = 'Magnificent effort ($totalSaved kg saved)! Shall we increase your daily goal by 10%?';
      }

      // 4. Create Butler Event
      await ButlerEvent.db.insertRow(
        session,
        ButlerEvent(
          userId: userId,
          type: 'audit',
          message: verdict,
          timestamp: DateTime.now(),
          isResolved: false,
        ),
      );
    }

    session.log('Midnight Audit completed for ${profiles.length} users.', level: LogLevel.info);
  }
}
