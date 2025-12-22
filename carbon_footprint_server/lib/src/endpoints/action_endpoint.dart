import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../business/action_service.dart';

class ActionEndpoint extends Endpoint {
  Future<void> logAction(Session session, ActionLog log) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return;
    final userId = userInfo.userId;
    
    log.userId = userId;
    await ActionService.logAction(session, userId, log);
  }

  Future<List<ActionLog>> getActions(Session session, int dummyId) async {
    final userInfo = await session.authenticated;
    print('DEBUG: getActions authenticated: ${userInfo?.userId}');
    if (userInfo == null) return [];

    final userId = userInfo.userId;
    return await ActionLog.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.date,
      orderDescending: true,
      include: ActionLog.include(action: EcoAction.include()),
    );
  }
}
