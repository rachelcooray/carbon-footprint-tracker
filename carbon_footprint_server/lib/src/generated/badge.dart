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

abstract class Badge implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Badge._({
    this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.earnedDate,
    this.iconType,
  });

  factory Badge({
    int? id,
    required int userId,
    required String name,
    required String description,
    required DateTime earnedDate,
    String? iconType,
  }) = _BadgeImpl;

  factory Badge.fromJson(Map<String, dynamic> jsonSerialization) {
    return Badge(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      earnedDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['earnedDate']),
      iconType: jsonSerialization['iconType'] as String?,
    );
  }

  static final t = BadgeTable();

  static const db = BadgeRepository._();

  @override
  int? id;

  int userId;

  String name;

  String description;

  DateTime earnedDate;

  String? iconType;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Badge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Badge copyWith({
    int? id,
    int? userId,
    String? name,
    String? description,
    DateTime? earnedDate,
    String? iconType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'earnedDate': earnedDate.toJson(),
      if (iconType != null) 'iconType': iconType,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'earnedDate': earnedDate.toJson(),
      if (iconType != null) 'iconType': iconType,
    };
  }

  static BadgeInclude include() {
    return BadgeInclude._();
  }

  static BadgeIncludeList includeList({
    _i1.WhereExpressionBuilder<BadgeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BadgeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BadgeTable>? orderByList,
    BadgeInclude? include,
  }) {
    return BadgeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Badge.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Badge.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BadgeImpl extends Badge {
  _BadgeImpl({
    int? id,
    required int userId,
    required String name,
    required String description,
    required DateTime earnedDate,
    String? iconType,
  }) : super._(
          id: id,
          userId: userId,
          name: name,
          description: description,
          earnedDate: earnedDate,
          iconType: iconType,
        );

  /// Returns a shallow copy of this [Badge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Badge copyWith({
    Object? id = _Undefined,
    int? userId,
    String? name,
    String? description,
    DateTime? earnedDate,
    Object? iconType = _Undefined,
  }) {
    return Badge(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      earnedDate: earnedDate ?? this.earnedDate,
      iconType: iconType is String? ? iconType : this.iconType,
    );
  }
}

class BadgeTable extends _i1.Table<int?> {
  BadgeTable({super.tableRelation}) : super(tableName: 'badge') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    earnedDate = _i1.ColumnDateTime(
      'earnedDate',
      this,
    );
    iconType = _i1.ColumnString(
      'iconType',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnDateTime earnedDate;

  late final _i1.ColumnString iconType;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        name,
        description,
        earnedDate,
        iconType,
      ];
}

class BadgeInclude extends _i1.IncludeObject {
  BadgeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Badge.t;
}

class BadgeIncludeList extends _i1.IncludeList {
  BadgeIncludeList._({
    _i1.WhereExpressionBuilder<BadgeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Badge.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Badge.t;
}

class BadgeRepository {
  const BadgeRepository._();

  /// Returns a list of [Badge]s matching the given query parameters.
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
  Future<List<Badge>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BadgeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BadgeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BadgeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Badge>(
      where: where?.call(Badge.t),
      orderBy: orderBy?.call(Badge.t),
      orderByList: orderByList?.call(Badge.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Badge] matching the given query parameters.
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
  Future<Badge?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BadgeTable>? where,
    int? offset,
    _i1.OrderByBuilder<BadgeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BadgeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Badge>(
      where: where?.call(Badge.t),
      orderBy: orderBy?.call(Badge.t),
      orderByList: orderByList?.call(Badge.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Badge] by its [id] or null if no such row exists.
  Future<Badge?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Badge>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Badge]s in the list and returns the inserted rows.
  ///
  /// The returned [Badge]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Badge>> insert(
    _i1.Session session,
    List<Badge> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Badge>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Badge] and returns the inserted row.
  ///
  /// The returned [Badge] will have its `id` field set.
  Future<Badge> insertRow(
    _i1.Session session,
    Badge row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Badge>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Badge]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Badge>> update(
    _i1.Session session,
    List<Badge> rows, {
    _i1.ColumnSelections<BadgeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Badge>(
      rows,
      columns: columns?.call(Badge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Badge]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Badge> updateRow(
    _i1.Session session,
    Badge row, {
    _i1.ColumnSelections<BadgeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Badge>(
      row,
      columns: columns?.call(Badge.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Badge]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Badge>> delete(
    _i1.Session session,
    List<Badge> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Badge>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Badge].
  Future<Badge> deleteRow(
    _i1.Session session,
    Badge row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Badge>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Badge>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BadgeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Badge>(
      where: where(Badge.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BadgeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Badge>(
      where: where?.call(Badge.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
