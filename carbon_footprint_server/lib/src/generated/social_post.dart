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

abstract class SocialPost
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SocialPost._({
    this.id,
    required this.userId,
    this.userName,
    required this.content,
    required this.timestamp,
    required this.type,
  });

  factory SocialPost({
    int? id,
    required int userId,
    String? userName,
    required String content,
    required DateTime timestamp,
    required String type,
  }) = _SocialPostImpl;

  factory SocialPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return SocialPost(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      userName: jsonSerialization['userName'] as String?,
      content: jsonSerialization['content'] as String,
      timestamp:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      type: jsonSerialization['type'] as String,
    );
  }

  static final t = SocialPostTable();

  static const db = SocialPostRepository._();

  @override
  int? id;

  int userId;

  String? userName;

  String content;

  DateTime timestamp;

  String type;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SocialPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SocialPost copyWith({
    int? id,
    int? userId,
    String? userName,
    String? content,
    DateTime? timestamp,
    String? type,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (userName != null) 'userName': userName,
      'content': content,
      'timestamp': timestamp.toJson(),
      'type': type,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (userName != null) 'userName': userName,
      'content': content,
      'timestamp': timestamp.toJson(),
      'type': type,
    };
  }

  static SocialPostInclude include() {
    return SocialPostInclude._();
  }

  static SocialPostIncludeList includeList({
    _i1.WhereExpressionBuilder<SocialPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SocialPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SocialPostTable>? orderByList,
    SocialPostInclude? include,
  }) {
    return SocialPostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SocialPost.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SocialPost.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SocialPostImpl extends SocialPost {
  _SocialPostImpl({
    int? id,
    required int userId,
    String? userName,
    required String content,
    required DateTime timestamp,
    required String type,
  }) : super._(
          id: id,
          userId: userId,
          userName: userName,
          content: content,
          timestamp: timestamp,
          type: type,
        );

  /// Returns a shallow copy of this [SocialPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SocialPost copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? userName = _Undefined,
    String? content,
    DateTime? timestamp,
    String? type,
  }) {
    return SocialPost(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      userName: userName is String? ? userName : this.userName,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
    );
  }
}

class SocialPostTable extends _i1.Table<int?> {
  SocialPostTable({super.tableRelation}) : super(tableName: 'social_post') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    userName = _i1.ColumnString(
      'userName',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString userName;

  late final _i1.ColumnString content;

  late final _i1.ColumnDateTime timestamp;

  late final _i1.ColumnString type;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        userName,
        content,
        timestamp,
        type,
      ];
}

class SocialPostInclude extends _i1.IncludeObject {
  SocialPostInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SocialPost.t;
}

class SocialPostIncludeList extends _i1.IncludeList {
  SocialPostIncludeList._({
    _i1.WhereExpressionBuilder<SocialPostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SocialPost.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SocialPost.t;
}

class SocialPostRepository {
  const SocialPostRepository._();

  /// Returns a list of [SocialPost]s matching the given query parameters.
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
  Future<List<SocialPost>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SocialPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SocialPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SocialPostTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SocialPost>(
      where: where?.call(SocialPost.t),
      orderBy: orderBy?.call(SocialPost.t),
      orderByList: orderByList?.call(SocialPost.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SocialPost] matching the given query parameters.
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
  Future<SocialPost?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SocialPostTable>? where,
    int? offset,
    _i1.OrderByBuilder<SocialPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SocialPostTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SocialPost>(
      where: where?.call(SocialPost.t),
      orderBy: orderBy?.call(SocialPost.t),
      orderByList: orderByList?.call(SocialPost.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SocialPost] by its [id] or null if no such row exists.
  Future<SocialPost?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SocialPost>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SocialPost]s in the list and returns the inserted rows.
  ///
  /// The returned [SocialPost]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SocialPost>> insert(
    _i1.Session session,
    List<SocialPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SocialPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SocialPost] and returns the inserted row.
  ///
  /// The returned [SocialPost] will have its `id` field set.
  Future<SocialPost> insertRow(
    _i1.Session session,
    SocialPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SocialPost>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SocialPost]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SocialPost>> update(
    _i1.Session session,
    List<SocialPost> rows, {
    _i1.ColumnSelections<SocialPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SocialPost>(
      rows,
      columns: columns?.call(SocialPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SocialPost]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SocialPost> updateRow(
    _i1.Session session,
    SocialPost row, {
    _i1.ColumnSelections<SocialPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SocialPost>(
      row,
      columns: columns?.call(SocialPost.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SocialPost]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SocialPost>> delete(
    _i1.Session session,
    List<SocialPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SocialPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SocialPost].
  Future<SocialPost> deleteRow(
    _i1.Session session,
    SocialPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SocialPost>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SocialPost>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SocialPostTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SocialPost>(
      where: where(SocialPost.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SocialPostTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SocialPost>(
      where: where?.call(SocialPost.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
