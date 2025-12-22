/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'community_group.dart' as _i2;

abstract class GroupMember
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = GroupMemberTable();

  static const db = GroupMemberRepository._();

  @override
  int? id;

  int groupId;

  _i2.CommunityGroup? group;

  int userId;

  DateTime joinedAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'groupId': groupId,
      if (group != null) 'group': group?.toJsonForProtocol(),
      'userId': userId,
      'joinedAt': joinedAt.toJson(),
    };
  }

  static GroupMemberInclude include({_i2.CommunityGroupInclude? group}) {
    return GroupMemberInclude._(group: group);
  }

  static GroupMemberIncludeList includeList({
    _i1.WhereExpressionBuilder<GroupMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GroupMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GroupMemberTable>? orderByList,
    GroupMemberInclude? include,
  }) {
    return GroupMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GroupMember.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(GroupMember.t),
      include: include,
    );
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

class GroupMemberTable extends _i1.Table<int?> {
  GroupMemberTable({super.tableRelation}) : super(tableName: 'group_member') {
    groupId = _i1.ColumnInt(
      'groupId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    joinedAt = _i1.ColumnDateTime(
      'joinedAt',
      this,
    );
  }

  late final _i1.ColumnInt groupId;

  _i2.CommunityGroupTable? _group;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnDateTime joinedAt;

  _i2.CommunityGroupTable get group {
    if (_group != null) return _group!;
    _group = _i1.createRelationTable(
      relationFieldName: 'group',
      field: GroupMember.t.groupId,
      foreignField: _i2.CommunityGroup.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CommunityGroupTable(tableRelation: foreignTableRelation),
    );
    return _group!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        groupId,
        userId,
        joinedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'group') {
      return group;
    }
    return null;
  }
}

class GroupMemberInclude extends _i1.IncludeObject {
  GroupMemberInclude._({_i2.CommunityGroupInclude? group}) {
    _group = group;
  }

  _i2.CommunityGroupInclude? _group;

  @override
  Map<String, _i1.Include?> get includes => {'group': _group};

  @override
  _i1.Table<int?> get table => GroupMember.t;
}

class GroupMemberIncludeList extends _i1.IncludeList {
  GroupMemberIncludeList._({
    _i1.WhereExpressionBuilder<GroupMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GroupMember.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => GroupMember.t;
}

class GroupMemberRepository {
  const GroupMemberRepository._();

  final attachRow = const GroupMemberAttachRowRepository._();

  /// Returns a list of [GroupMember]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<GroupMember>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GroupMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GroupMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GroupMemberTable>? orderByList,
    _i1.Transaction? transaction,
    GroupMemberInclude? include,
  }) async {
    return session.db.find<GroupMember>(
      where: where?.call(GroupMember.t),
      orderBy: orderBy?.call(GroupMember.t),
      orderByList: orderByList?.call(GroupMember.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [GroupMember] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<GroupMember?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GroupMemberTable>? where,
    int? offset,
    _i1.OrderByBuilder<GroupMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GroupMemberTable>? orderByList,
    _i1.Transaction? transaction,
    GroupMemberInclude? include,
  }) async {
    return session.db.findFirstRow<GroupMember>(
      where: where?.call(GroupMember.t),
      orderBy: orderBy?.call(GroupMember.t),
      orderByList: orderByList?.call(GroupMember.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [GroupMember] by its [id] or null if no such row exists.
  Future<GroupMember?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    GroupMemberInclude? include,
  }) async {
    return session.db.findById<GroupMember>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [GroupMember]s in the list and returns the inserted rows.
  ///
  /// The returned [GroupMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<GroupMember>> insert(
    _i1.Session session,
    List<GroupMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<GroupMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [GroupMember] and returns the inserted row.
  ///
  /// The returned [GroupMember] will have its `id` field set.
  Future<GroupMember> insertRow(
    _i1.Session session,
    GroupMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<GroupMember>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [GroupMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<GroupMember>> update(
    _i1.Session session,
    List<GroupMember> rows, {
    _i1.ColumnSelections<GroupMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<GroupMember>(
      rows,
      columns: columns?.call(GroupMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GroupMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GroupMember> updateRow(
    _i1.Session session,
    GroupMember row, {
    _i1.ColumnSelections<GroupMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<GroupMember>(
      row,
      columns: columns?.call(GroupMember.t),
      transaction: transaction,
    );
  }

  /// Deletes all [GroupMember]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<GroupMember>> delete(
    _i1.Session session,
    List<GroupMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<GroupMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [GroupMember].
  Future<GroupMember> deleteRow(
    _i1.Session session,
    GroupMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GroupMember>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<GroupMember>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GroupMemberTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<GroupMember>(
      where: where(GroupMember.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GroupMemberTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<GroupMember>(
      where: where?.call(GroupMember.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class GroupMemberAttachRowRepository {
  const GroupMemberAttachRowRepository._();

  /// Creates a relation between the given [GroupMember] and [CommunityGroup]
  /// by setting the [GroupMember]'s foreign key `groupId` to refer to the [CommunityGroup].
  Future<void> group(
    _i1.Session session,
    GroupMember groupMember,
    _i2.CommunityGroup group, {
    _i1.Transaction? transaction,
  }) async {
    if (groupMember.id == null) {
      throw ArgumentError.notNull('groupMember.id');
    }
    if (group.id == null) {
      throw ArgumentError.notNull('group.id');
    }

    var $groupMember = groupMember.copyWith(groupId: group.id);
    await session.db.updateRow<GroupMember>(
      $groupMember,
      columns: [GroupMember.t.groupId],
      transaction: transaction,
    );
  }
}
