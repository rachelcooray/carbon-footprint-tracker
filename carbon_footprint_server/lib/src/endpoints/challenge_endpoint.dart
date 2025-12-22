import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';

class ChallengeEndpoint extends Endpoint {
  Future<List<ChallengeProgress>> getUserChallenges(Session session, int dummyId) async {
    final userInfo = await session.authenticated;
    print('DEBUG: getUserChallenges for userId: ${userInfo?.userId}');
    if (userInfo == null) return [];

    final challenges = await Challenge.db.find(session);
    print('DEBUG: Found ${challenges.length} total challenges in DB');

    List<ChallengeProgress> results = [];

    // 2. For each challenge, calculate progress
    for (var challenge in challenges) {
      // Calculate total quantity logged for this specific action type
      final relevantLogs = await ActionLog.db.find(
        session,
        where: (t) => t.userId.equals(userInfo.userId) & t.actionId.equals(challenge.targetActionId),
      );
      print('DEBUG: Challenge "${challenge.title}" has ${relevantLogs.length} relevant logs for user');

      double currentAmount = 0;
      for (var log in relevantLogs) {
        currentAmount += log.quantity;
      }

      double percent = 0;
      if (challenge.targetAmount > 0) {
        percent = currentAmount / challenge.targetAmount;
        if (percent > 1.0) percent = 1.0;
      }

      results.add(ChallengeProgress(
        challenge: challenge,
        currentAmount: currentAmount,
        percentComplete: percent,
      ));
    }
    
    print('DEBUG: Returning ${results.length} ChallengeProgress items');
    return results;
  }
}
