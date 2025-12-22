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

abstract class CommunityGroup
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CommunityGroup._({
    this.id,
    required this.name,
    required this.description,
    double? totalImpact,
    int? memberCount,
  })  : totalImpact = totalImpact ?? 0.0,
        memberCount = memberCount ?? 0;

  factory CommunityGroup({
    int? id,
    required String name,
    required String description,
    double? totalImpact,
    int? memberCount,
  }) = _CommunityGroupImpl;

  factory CommunityGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommunityGroup(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      totalImpact: (jsonSerialization['totalImpact'] as num).toDouble(),
      memberCount: jsonSerialization['memberCount'] as int,
    );
  }

  static final t = CommunityGroupTable();

  static const db = CommunityGroupRepository._();

  @override
  int? id;

  String name;

  String description;

  double totalImpact;

  int memberCount;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CommunityGroup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommunityGroup copyWith({
    int? id,
    String? name,
    String? description,
    double? totalImpact,
    int? memberCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'totalImpact': totalImpact,
      'memberCount': memberCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'totalImpact': totalImpact,
      'memberCount': memberCount,
    };
  }

  static CommunityGroupInclude include() {
    return CommunityGroupInclude._();
  }

  static CommunityGroupIncludeList includeList({
    _i1.WhereExpressionBuilder<CommunityGroupTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommunityGroupTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommunityGroupTable>? orderByList,
    CommunityGroupInclude? include,
  }) {
    return CommunityGroupIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommunityGroup.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CommunityGroup.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommunityGroupImpl extends CommunityGroup {
  _CommunityGroupImpl({
    int? id,
    required String name,
    required String description,
    double? totalImpact,
    int? memberCount,
  }) : super._(
          id: id,
          name: name,
          description: description,
          totalImpact: totalImpact,
          memberCount: memberCount,
        );

  /// Returns a shallow copy of this [CommunityGroup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommunityGroup copyWith({
    Object? id = _Undefined,
    String? name,
    String? description,
    double? totalImpact,
    int? memberCount,
  }) {
    return CommunityGroup(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      totalImpact: totalImpact ?? this.totalImpact,
      memberCount: memberCount ?? this.memberCount,
    );
  }
}

class CommunityGroupTable extends _i1.Table<int?> {
  CommunityGroupTable({super.tableRelation})
      : super(tableName: 'community_group') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    totalImpact = _i1.ColumnDouble(
      'totalImpact',
      this,
      hasDefault: true,
    );
    memberCount = _i1.ColumnInt(
      'memberCount',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnDouble totalImpact;

  late final _i1.ColumnInt memberCount;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        totalImpact,
        memberCount,
      ];
}

class CommunityGroupInclude extends _i1.IncludeObject {
  CommunityGroupInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CommunityGroup.t;
}

class CommunityGroupIncludeList extends _i1.IncludeList {
  CommunityGroupIncludeList._({
    _i1.WhereExpressionBuilder<CommunityGroupTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CommunityGroup.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CommunityGroup.t;
}

class CommunityGroupRepository {
  const CommunityGroupRepository._();

  /// Returns a list of [CommunityGroup]s matching the given query parameters.
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
  Future<List<CommunityGroup>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommunityGroupTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommunityGroupTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommunityGroupTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CommunityGroup>(
      where: where?.call(CommunityGroup.t),
      orderBy: orderBy?.call(CommunityGroup.t),
      orderByList: orderByList?.call(CommunityGroup.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CommunityGroup] matching the given query parameters.
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
  Future<CommunityGroup?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommunityGroupTable>? where,
    int? offset,
    _i1.OrderByBuilder<CommunityGroupTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommunityGroupTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CommunityGroup>(
      where: where?.call(CommunityGroup.t),
      orderBy: orderBy?.call(CommunityGroup.t),
      orderByList: orderByList?.call(CommunityGroup.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CommunityGroup] by its [id] or null if no such row exists.
  Future<CommunityGroup?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CommunityGroup>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CommunityGroup]s in the list and returns the inserted rows.
  ///
  /// The returned [CommunityGroup]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CommunityGroup>> insert(
    _i1.Session session,
    List<CommunityGroup> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CommunityGroup>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CommunityGroup] and returns the inserted row.
  ///
  /// The returned [CommunityGroup] will have its `id` field set.
  Future<CommunityGroup> insertRow(
    _i1.Session session,
    CommunityGroup row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CommunityGroup>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CommunityGroup]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CommunityGroup>> update(
    _i1.Session session,
    List<CommunityGroup> rows, {
    _i1.ColumnSelections<CommunityGroupTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CommunityGroup>(
      rows,
      columns: columns?.call(CommunityGroup.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommunityGroup]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CommunityGroup> updateRow(
    _i1.Session session,
    CommunityGroup row, {
    _i1.ColumnSelections<CommunityGroupTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CommunityGroup>(
      row,
      columns: columns?.call(CommunityGroup.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CommunityGroup]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CommunityGroup>> delete(
    _i1.Session session,
    List<CommunityGroup> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CommunityGroup>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CommunityGroup].
  Future<CommunityGroup> deleteRow(
    _i1.Session session,
    CommunityGroup row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CommunityGroup>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CommunityGroup>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CommunityGroupTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CommunityGroup>(
      where: where(CommunityGroup.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommunityGroupTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CommunityGroup>(
      where: where?.call(CommunityGroup.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
