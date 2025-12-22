/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'greeting.dart' as _i4;
import 'action_log.dart' as _i5;
import 'badge.dart' as _i6;
import 'butler_event.dart' as _i7;
import 'butler_message.dart' as _i8;
import 'challenge.dart' as _i9;
import 'challenge_progress.dart' as _i10;
import 'community_group.dart' as _i11;
import 'eco_action.dart' as _i12;
import 'ecotrajectory.dart' as _i13;
import 'group_member.dart' as _i14;
import 'social_post.dart' as _i15;
import 'user_profile.dart' as _i16;
import 'user_stats.dart' as _i17;
import 'package:carbon_footprint_server/src/generated/action_log.dart' as _i18;
import 'package:carbon_footprint_server/src/generated/butler_message.dart'
    as _i19;
import 'package:carbon_footprint_server/src/generated/butler_event.dart'
    as _i20;
import 'package:carbon_footprint_server/src/generated/challenge_progress.dart'
    as _i21;
import 'package:carbon_footprint_server/src/generated/community_group.dart'
    as _i22;
import 'package:carbon_footprint_server/src/generated/eco_action.dart' as _i23;
import 'package:carbon_footprint_server/src/generated/social_post.dart' as _i24;
import 'package:carbon_footprint_server/src/generated/user_profile.dart'
    as _i25;
import 'package:carbon_footprint_server/src/generated/badge.dart' as _i26;
export 'greeting.dart';
export 'action_log.dart';
export 'badge.dart';
export 'butler_event.dart';
export 'butler_message.dart';
export 'challenge.dart';
export 'challenge_progress.dart';
export 'community_group.dart';
export 'eco_action.dart';
export 'ecotrajectory.dart';
export 'group_member.dart';
export 'social_post.dart';
export 'user_profile.dart';
export 'user_stats.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'action_log',
      dartName: 'ActionLog',
      schema: 'public',
      module: 'carbon_footprint',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'action_log_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'actionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'co2Saved',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'action_log_fk_0',
          columns: ['actionId'],
          referenceTable: 'eco_action',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'action_log_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'badge',
      dartName: 'Badge',
      schema: 'public',
      module: 'carbon_footprint',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'badge_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'earnedDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'iconType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'badge_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'butler_event',
      dartName: 'ButlerEvent',
      schema: 'public',
      module: 'carbon_footprint',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'butler_event_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'message',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'isResolved',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'butler_event_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'butler_message',
      dartName: 'ButlerMessage',
      schema: 'public',
      module: 'carbon_footprint',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'butler_message_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isFromButler',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'butler_message_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'challenge',
      dartName: 'Challenge',
      schema: 'public',
      module: 'carbon_footprint',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'challenge_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetActionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'targetAmount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'unit',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'points',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'durationDays',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'challenge_fk_0',
          columns: ['targetActionId'],
          referenceTable: 'eco_action',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'challenge_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'community_group',
      dartName: 'CommunityGroup',
      schema: 'public',
      module: 'carbon_footprint',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'community_group_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'totalImpact',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'memberCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'community_group_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'eco_action',
      dartName: 'EcoAction',
      schema: 'public',
      module: 'carbon_footprint',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'eco_action_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'co2Factor',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'unit',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'eco_action_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'group_member',
      dartName: 'GroupMember',
      schema: 'public',
      module: 'carbon_footprint',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'group_member_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'groupId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'joinedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'group_member_fk_0',
          columns: ['groupId'],
          referenceTable: 'community_group',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'group_member_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'social_post',
      dartName: 'SocialPost',
      schema: 'public',
      module: 'carbon_footprint',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'social_post_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'social_post_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_profile',
      dartName: 'UserProfile',
      schema: 'public',
      module: 'carbon_footprint',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_profile_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'ecoScore',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'joinedDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _i2.ColumnDefinition(
          name: 'streakDays',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'lastActionDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'monthlyBudget',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '200.0',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_profile_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i4.Greeting) {
      return _i4.Greeting.fromJson(data) as T;
    }
    if (t == _i5.ActionLog) {
      return _i5.ActionLog.fromJson(data) as T;
    }
    if (t == _i6.Badge) {
      return _i6.Badge.fromJson(data) as T;
    }
    if (t == _i7.ButlerEvent) {
      return _i7.ButlerEvent.fromJson(data) as T;
    }
    if (t == _i8.ButlerMessage) {
      return _i8.ButlerMessage.fromJson(data) as T;
    }
    if (t == _i9.Challenge) {
      return _i9.Challenge.fromJson(data) as T;
    }
    if (t == _i10.ChallengeProgress) {
      return _i10.ChallengeProgress.fromJson(data) as T;
    }
    if (t == _i11.CommunityGroup) {
      return _i11.CommunityGroup.fromJson(data) as T;
    }
    if (t == _i12.EcoAction) {
      return _i12.EcoAction.fromJson(data) as T;
    }
    if (t == _i13.Ecotrajectory) {
      return _i13.Ecotrajectory.fromJson(data) as T;
    }
    if (t == _i14.GroupMember) {
      return _i14.GroupMember.fromJson(data) as T;
    }
    if (t == _i15.SocialPost) {
      return _i15.SocialPost.fromJson(data) as T;
    }
    if (t == _i16.UserProfile) {
      return _i16.UserProfile.fromJson(data) as T;
    }
    if (t == _i17.UserStats) {
      return _i17.UserStats.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.Greeting?>()) {
      return (data != null ? _i4.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ActionLog?>()) {
      return (data != null ? _i5.ActionLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Badge?>()) {
      return (data != null ? _i6.Badge.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ButlerEvent?>()) {
      return (data != null ? _i7.ButlerEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ButlerMessage?>()) {
      return (data != null ? _i8.ButlerMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Challenge?>()) {
      return (data != null ? _i9.Challenge.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.ChallengeProgress?>()) {
      return (data != null ? _i10.ChallengeProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CommunityGroup?>()) {
      return (data != null ? _i11.CommunityGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.EcoAction?>()) {
      return (data != null ? _i12.EcoAction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Ecotrajectory?>()) {
      return (data != null ? _i13.Ecotrajectory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.GroupMember?>()) {
      return (data != null ? _i14.GroupMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.SocialPost?>()) {
      return (data != null ? _i15.SocialPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.UserProfile?>()) {
      return (data != null ? _i16.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.UserStats?>()) {
      return (data != null ? _i17.UserStats.fromJson(data) : null) as T;
    }
    if (t == List<_i18.ActionLog>) {
      return (data as List).map((e) => deserialize<_i18.ActionLog>(e)).toList()
          as T;
    }
    if (t == List<_i19.ButlerMessage>) {
      return (data as List)
          .map((e) => deserialize<_i19.ButlerMessage>(e))
          .toList() as T;
    }
    if (t == List<_i20.ButlerEvent>) {
      return (data as List)
          .map((e) => deserialize<_i20.ButlerEvent>(e))
          .toList() as T;
    }
    if (t == List<_i21.ChallengeProgress>) {
      return (data as List)
          .map((e) => deserialize<_i21.ChallengeProgress>(e))
          .toList() as T;
    }
    if (t == List<_i22.CommunityGroup>) {
      return (data as List)
          .map((e) => deserialize<_i22.CommunityGroup>(e))
          .toList() as T;
    }
    if (t == List<_i23.EcoAction>) {
      return (data as List).map((e) => deserialize<_i23.EcoAction>(e)).toList()
          as T;
    }
    if (t == List<_i24.SocialPost>) {
      return (data as List).map((e) => deserialize<_i24.SocialPost>(e)).toList()
          as T;
    }
    if (t == List<_i25.UserProfile>) {
      return (data as List)
          .map((e) => deserialize<_i25.UserProfile>(e))
          .toList() as T;
    }
    if (t == List<_i26.Badge>) {
      return (data as List).map((e) => deserialize<_i26.Badge>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i4.Greeting) {
      return 'Greeting';
    }
    if (data is _i5.ActionLog) {
      return 'ActionLog';
    }
    if (data is _i6.Badge) {
      return 'Badge';
    }
    if (data is _i7.ButlerEvent) {
      return 'ButlerEvent';
    }
    if (data is _i8.ButlerMessage) {
      return 'ButlerMessage';
    }
    if (data is _i9.Challenge) {
      return 'Challenge';
    }
    if (data is _i10.ChallengeProgress) {
      return 'ChallengeProgress';
    }
    if (data is _i11.CommunityGroup) {
      return 'CommunityGroup';
    }
    if (data is _i12.EcoAction) {
      return 'EcoAction';
    }
    if (data is _i13.Ecotrajectory) {
      return 'Ecotrajectory';
    }
    if (data is _i14.GroupMember) {
      return 'GroupMember';
    }
    if (data is _i15.SocialPost) {
      return 'SocialPost';
    }
    if (data is _i16.UserProfile) {
      return 'UserProfile';
    }
    if (data is _i17.UserStats) {
      return 'UserStats';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i4.Greeting>(data['data']);
    }
    if (dataClassName == 'ActionLog') {
      return deserialize<_i5.ActionLog>(data['data']);
    }
    if (dataClassName == 'Badge') {
      return deserialize<_i6.Badge>(data['data']);
    }
    if (dataClassName == 'ButlerEvent') {
      return deserialize<_i7.ButlerEvent>(data['data']);
    }
    if (dataClassName == 'ButlerMessage') {
      return deserialize<_i8.ButlerMessage>(data['data']);
    }
    if (dataClassName == 'Challenge') {
      return deserialize<_i9.Challenge>(data['data']);
    }
    if (dataClassName == 'ChallengeProgress') {
      return deserialize<_i10.ChallengeProgress>(data['data']);
    }
    if (dataClassName == 'CommunityGroup') {
      return deserialize<_i11.CommunityGroup>(data['data']);
    }
    if (dataClassName == 'EcoAction') {
      return deserialize<_i12.EcoAction>(data['data']);
    }
    if (dataClassName == 'Ecotrajectory') {
      return deserialize<_i13.Ecotrajectory>(data['data']);
    }
    if (dataClassName == 'GroupMember') {
      return deserialize<_i14.GroupMember>(data['data']);
    }
    if (dataClassName == 'SocialPost') {
      return deserialize<_i15.SocialPost>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i16.UserProfile>(data['data']);
    }
    if (dataClassName == 'UserStats') {
      return deserialize<_i17.UserStats>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.ActionLog:
        return _i5.ActionLog.t;
      case _i6.Badge:
        return _i6.Badge.t;
      case _i7.ButlerEvent:
        return _i7.ButlerEvent.t;
      case _i8.ButlerMessage:
        return _i8.ButlerMessage.t;
      case _i9.Challenge:
        return _i9.Challenge.t;
      case _i11.CommunityGroup:
        return _i11.CommunityGroup.t;
      case _i12.EcoAction:
        return _i12.EcoAction.t;
      case _i14.GroupMember:
        return _i14.GroupMember.t;
      case _i15.SocialPost:
        return _i15.SocialPost.t;
      case _i16.UserProfile:
        return _i16.UserProfile.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'carbon_footprint';
}
