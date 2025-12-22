/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'community_group.dart' as _i2;

abstract class GroupMember implements _i1.SerializableModel {
  GroupMember._({
    this.id,
    required this.groupId,
    this.group,
    required this.userId,
    required this.joinedAt,
  });

  factory GroupMember({
    int? id,
    required int groupId,
    _i2.CommunityGroup? group,
    required int userId,
    required DateTime joinedAt,
  }) = _GroupMemberImpl;

  factory GroupMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return GroupMember(
      id: jsonSerialization['id'] as int?,
      groupId: jsonSerialization['groupId'] as int,
      group: jsonSerialization['group'] == null
          ? null
          : _i2.CommunityGroup.fromJson(
              (jsonSerialization['group'] as Map<String, dynamic>)),
      userId: jsonSerialization['userId'] as int,
      joinedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int groupId;

  _i2.CommunityGroup? group;

  int userId;

  DateTime joinedAt;

  /// Returns a shallow copy of this [GroupMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GroupMember copyWith({
    int? id,
    int? groupId,
    _i2.CommunityGroup? group,
    int? userId,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'groupId': groupId,
      if (group != null) 'group': group?.toJson(),
      'userId': userId,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GroupMemberImpl extends GroupMember {
  _GroupMemberImpl({
    int? id,
    required int groupId,
    _i2.CommunityGroup? group,
    required int userId,
    required DateTime joinedAt,
  }) : super._(
          id: id,
          groupId: groupId,
          group: group,
          userId: userId,
          joinedAt: joinedAt,
        );

  /// Returns a shallow copy of this [GroupMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GroupMember copyWith({
    Object? id = _Undefined,
    int? groupId,
    Object? group = _Undefined,
    int? userId,
    DateTime? joinedAt,
  }) {
    return GroupMember(
      id: id is int? ? id : this.id,
      groupId: groupId ?? this.groupId,
      group: group is _i2.CommunityGroup? ? group : this.group?.copyWith(),
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
