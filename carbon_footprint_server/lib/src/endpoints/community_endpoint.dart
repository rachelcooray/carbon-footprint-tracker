import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';

class CommunityEndpoint extends Endpoint {
  Future<List<CommunityGroup>> getGroups(Session session) async {
    return await CommunityGroup.db.find(
      session,
      orderBy: (t) => t.memberCount,
      orderDescending: true,
    );
  }

  Future<void> createGroup(Session session, String name, String description) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return;

    final group = CommunityGroup(
      name: name,
      description: description,
      totalImpact: 0,
      memberCount: 1,
    );
    final inserted = await CommunityGroup.db.insertRow(session, group);

    await GroupMember.db.insertRow(session, GroupMember(
      groupId: inserted.id!,
      userId: userInfo.userId,
      joinedAt: DateTime.now(),
    ));

    await SocialPost.db.insertRow(session, SocialPost(
      userId: userInfo.userId,
      userName: (await Users.findUserByUserId(session, userInfo.userId))?.userName,
      content: 'just created a new community: $name! Join us in our noble quest.',
      timestamp: DateTime.now(),
      type: 'group_created',
    ));

    // Award "Eco Pioneer" badge
    final existingBadge = await Badge.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userInfo.userId) & t.name.equals('Eco Pioneer'),
    );
    if (existingBadge == null) {
      await Badge.db.insertRow(session, Badge(
        userId: userInfo.userId,
        name: 'Eco Pioneer',
        description: 'Founded a community for collective impact.',
        earnedDate: DateTime.now(),
        iconType: 'pioneer',
      ));

      await ButlerEvent.db.insertRow(session, ButlerEvent(
        userId: userInfo.userId,
        type: 'celebration',
        message: 'A leader emerges! You have founded the "$name" community, sir/madam. You are officially an "Eco Pioneer"!',
        timestamp: DateTime.now(),
        isResolved: false,
      ));
    }
  }

  Future<void> joinGroup(Session session, int groupId) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return;

    // Check if already a member
    final existing = await GroupMember.db.findFirstRow(
      session,
      where: (t) => t.groupId.equals(groupId) & t.userId.equals(userInfo.userId),
    );
    if (existing != null) return;

    await GroupMember.db.insertRow(session, GroupMember(
      groupId: groupId,
      userId: userInfo.userId,
      joinedAt: DateTime.now(),
    ));

    final group = await CommunityGroup.db.findById(session, groupId);
    if (group != null) {
      group.memberCount += 1;
      await CommunityGroup.db.updateRow(session, group);
    }
  }

  Future<List<CommunityGroup>> getMyGroups(Session session) async {
    final userInfo = await session.authenticated;
    if (userInfo == null) return [];

    final memberships = await GroupMember.db.find(
      session,
      where: (t) => t.userId.equals(userInfo.userId),
      include: GroupMember.include(group: CommunityGroup.include()),
    );

    return memberships.map((m) => m.group!).toList();
  }
}
