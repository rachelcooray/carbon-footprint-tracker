import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class EcoActionEndpoint extends Endpoint {
  Future<List<EcoAction>> getAllActions(Session session) async {
    return await EcoAction.db.find(
      session,
      orderBy: (t) => t.name,
    );
  }
}
