import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';

class SocialEndpoint extends Endpoint {
  Future<List<SocialPost>> getFeed(Session session) async {
    return await SocialPost.db.find(
      session,
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: 20,
    );
  }

  Future<double> getGlobalImpact(Session session) async {
    // Sum all CO2 saved from all logs
    final logs = await ActionLog.db.find(session);
    double total = 0;
    for (var log in logs) {
      total += log.co2Saved;
    }
    return total;
  }

  Future<void> cheerUser(Session session, int targetUserId) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return;
    final sender = await Users.findUserByUserId(session, userInfo.userId);
    final name = sender?.userName ?? "a fellow tracker";

    await ButlerMessage.db.insertRow(session, ButlerMessage(
      userId: targetUserId,
      text: 'Good news, sir/madam! Your companion $name has sent you a formal "Cheer" for your excellent eco-progress. A splendid show indeed!',
      isFromButler: true,
      timestamp: DateTime.now(),
    ));
  }

  Future<void> nudgeUser(Session session, int targetUserId) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return;
    final sender = await Users.findUserByUserId(session, userInfo.userId);
    final name = sender?.userName ?? "a fellow tracker";

    await ButlerMessage.db.insertRow(session, ButlerMessage(
      userId: targetUserId,
      text: 'I apologize for the interruption, sir/madam, but $name has requested that I "Nudge" you. They are eagerly awaiting your next noble eco-action!',
      isFromButler: true,
      timestamp: DateTime.now(),
    ));
  }
}
