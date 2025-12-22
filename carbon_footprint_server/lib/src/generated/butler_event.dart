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

abstract class ButlerEvent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ButlerEvent._({
    this.id,
    required this.userId,
    required this.type,
    required this.message,
    required this.timestamp,
    required this.isResolved,
  });

  factory ButlerEvent({
    int? id,
    required int userId,
    required String type,
    required String message,
    required DateTime timestamp,
    required bool isResolved,
  }) = _ButlerEventImpl;

  factory ButlerEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return ButlerEvent(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      type: jsonSerialization['type'] as String,
      message: jsonSerialization['message'] as String,
      timestamp:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      isResolved: jsonSerialization['isResolved'] as bool,
    );
  }

  static final t = ButlerEventTable();

  static const db = ButlerEventRepository._();

  @override
  int? id;

  int userId;

  String type;

  String message;

  DateTime timestamp;

  bool isResolved;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ButlerEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ButlerEvent copyWith({
    int? id,
    int? userId,
    String? type,
    String? message,
    DateTime? timestamp,
    bool? isResolved,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'type': type,
      'message': message,
      'timestamp': timestamp.toJson(),
      'isResolved': isResolved,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'type': type,
      'message': message,
      'timestamp': timestamp.toJson(),
      'isResolved': isResolved,
    };
  }

  static ButlerEventInclude include() {
    return ButlerEventInclude._();
  }

  static ButlerEventIncludeList includeList({
    _i1.WhereExpressionBuilder<ButlerEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ButlerEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ButlerEventTable>? orderByList,
    ButlerEventInclude? include,
  }) {
    return ButlerEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ButlerEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ButlerEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ButlerEventImpl extends ButlerEvent {
  _ButlerEventImpl({
    int? id,
    required int userId,
    required String type,
    required String message,
    required DateTime timestamp,
    required bool isResolved,
  }) : super._(
          id: id,
          userId: userId,
          type: type,
          message: message,
          timestamp: timestamp,
          isResolved: isResolved,
        );

  /// Returns a shallow copy of this [ButlerEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ButlerEvent copyWith({
    Object? id = _Undefined,
    int? userId,
    String? type,
    String? message,
    DateTime? timestamp,
    bool? isResolved,
  }) {
    return ButlerEvent(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isResolved: isResolved ?? this.isResolved,
    );
  }
}

class ButlerEventTable extends _i1.Table<int?> {
  ButlerEventTable({super.tableRelation}) : super(tableName: 'butler_event') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    message = _i1.ColumnString(
      'message',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
    isResolved = _i1.ColumnBool(
      'isResolved',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString type;

  late final _i1.ColumnString message;

  late final _i1.ColumnDateTime timestamp;

  late final _i1.ColumnBool isResolved;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        type,
        message,
        timestamp,
        isResolved,
      ];
}

class ButlerEventInclude extends _i1.IncludeObject {
  ButlerEventInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ButlerEvent.t;
}

class ButlerEventIncludeList extends _i1.IncludeList {
  ButlerEventIncludeList._({
    _i1.WhereExpressionBuilder<ButlerEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ButlerEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ButlerEvent.t;
}

class ButlerEventRepository {
  const ButlerEventRepository._();

  /// Returns a list of [ButlerEvent]s matching the given query parameters.
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
  Future<List<ButlerEvent>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ButlerEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ButlerEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ButlerEventTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ButlerEvent>(
      where: where?.call(ButlerEvent.t),
      orderBy: orderBy?.call(ButlerEvent.t),
      orderByList: orderByList?.call(ButlerEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ButlerEvent] matching the given query parameters.
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
  Future<ButlerEvent?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ButlerEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<ButlerEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ButlerEventTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ButlerEvent>(
      where: where?.call(ButlerEvent.t),
      orderBy: orderBy?.call(ButlerEvent.t),
      orderByList: orderByList?.call(ButlerEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ButlerEvent] by its [id] or null if no such row exists.
  Future<ButlerEvent?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ButlerEvent>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ButlerEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [ButlerEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ButlerEvent>> insert(
    _i1.Session session,
    List<ButlerEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ButlerEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ButlerEvent] and returns the inserted row.
  ///
  /// The returned [ButlerEvent] will have its `id` field set.
  Future<ButlerEvent> insertRow(
    _i1.Session session,
    ButlerEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ButlerEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ButlerEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ButlerEvent>> update(
    _i1.Session session,
    List<ButlerEvent> rows, {
    _i1.ColumnSelections<ButlerEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ButlerEvent>(
      rows,
      columns: columns?.call(ButlerEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ButlerEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ButlerEvent> updateRow(
    _i1.Session session,
    ButlerEvent row, {
    _i1.ColumnSelections<ButlerEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ButlerEvent>(
      row,
      columns: columns?.call(ButlerEvent.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ButlerEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ButlerEvent>> delete(
    _i1.Session session,
    List<ButlerEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ButlerEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ButlerEvent].
  Future<ButlerEvent> deleteRow(
    _i1.Session session,
    ButlerEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ButlerEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ButlerEvent>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ButlerEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ButlerEvent>(
      where: where(ButlerEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ButlerEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ButlerEvent>(
      where: where?.call(ButlerEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
