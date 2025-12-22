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

abstract class ButlerMessage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ButlerMessage._({
    this.id,
    required this.userId,
    required this.text,
    required this.isFromButler,
    required this.timestamp,
  });

  factory ButlerMessage({
    int? id,
    required int userId,
    required String text,
    required bool isFromButler,
    required DateTime timestamp,
  }) = _ButlerMessageImpl;

  factory ButlerMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ButlerMessage(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      text: jsonSerialization['text'] as String,
      isFromButler: jsonSerialization['isFromButler'] as bool,
      timestamp:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  static final t = ButlerMessageTable();

  static const db = ButlerMessageRepository._();

  @override
  int? id;

  int userId;

  String text;

  bool isFromButler;

  DateTime timestamp;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ButlerMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ButlerMessage copyWith({
    int? id,
    int? userId,
    String? text,
    bool? isFromButler,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'text': text,
      'isFromButler': isFromButler,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'text': text,
      'isFromButler': isFromButler,
      'timestamp': timestamp.toJson(),
    };
  }

  static ButlerMessageInclude include() {
    return ButlerMessageInclude._();
  }

  static ButlerMessageIncludeList includeList({
    _i1.WhereExpressionBuilder<ButlerMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ButlerMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ButlerMessageTable>? orderByList,
    ButlerMessageInclude? include,
  }) {
    return ButlerMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ButlerMessage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ButlerMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ButlerMessageImpl extends ButlerMessage {
  _ButlerMessageImpl({
    int? id,
    required int userId,
    required String text,
    required bool isFromButler,
    required DateTime timestamp,
  }) : super._(
          id: id,
          userId: userId,
          text: text,
          isFromButler: isFromButler,
          timestamp: timestamp,
        );

  /// Returns a shallow copy of this [ButlerMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ButlerMessage copyWith({
    Object? id = _Undefined,
    int? userId,
    String? text,
    bool? isFromButler,
    DateTime? timestamp,
  }) {
    return ButlerMessage(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      text: text ?? this.text,
      isFromButler: isFromButler ?? this.isFromButler,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class ButlerMessageTable extends _i1.Table<int?> {
  ButlerMessageTable({super.tableRelation})
      : super(tableName: 'butler_message') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    text = _i1.ColumnString(
      'text',
      this,
    );
    isFromButler = _i1.ColumnBool(
      'isFromButler',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString text;

  late final _i1.ColumnBool isFromButler;

  late final _i1.ColumnDateTime timestamp;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        text,
        isFromButler,
        timestamp,
      ];
}

class ButlerMessageInclude extends _i1.IncludeObject {
  ButlerMessageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ButlerMessage.t;
}

class ButlerMessageIncludeList extends _i1.IncludeList {
  ButlerMessageIncludeList._({
    _i1.WhereExpressionBuilder<ButlerMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ButlerMessage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ButlerMessage.t;
}

class ButlerMessageRepository {
  const ButlerMessageRepository._();

  /// Returns a list of [ButlerMessage]s matching the given query parameters.
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
  Future<List<ButlerMessage>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ButlerMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ButlerMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ButlerMessageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ButlerMessage>(
      where: where?.call(ButlerMessage.t),
      orderBy: orderBy?.call(ButlerMessage.t),
      orderByList: orderByList?.call(ButlerMessage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ButlerMessage] matching the given query parameters.
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
  Future<ButlerMessage?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ButlerMessageTable>? where,
    int? offset,
    _i1.OrderByBuilder<ButlerMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ButlerMessageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ButlerMessage>(
      where: where?.call(ButlerMessage.t),
      orderBy: orderBy?.call(ButlerMessage.t),
      orderByList: orderByList?.call(ButlerMessage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ButlerMessage] by its [id] or null if no such row exists.
  Future<ButlerMessage?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ButlerMessage>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ButlerMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [ButlerMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ButlerMessage>> insert(
    _i1.Session session,
    List<ButlerMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ButlerMessage>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ButlerMessage] and returns the inserted row.
  ///
  /// The returned [ButlerMessage] will have its `id` field set.
  Future<ButlerMessage> insertRow(
    _i1.Session session,
    ButlerMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ButlerMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ButlerMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ButlerMessage>> update(
    _i1.Session session,
    List<ButlerMessage> rows, {
    _i1.ColumnSelections<ButlerMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ButlerMessage>(
      rows,
      columns: columns?.call(ButlerMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ButlerMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ButlerMessage> updateRow(
    _i1.Session session,
    ButlerMessage row, {
    _i1.ColumnSelections<ButlerMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ButlerMessage>(
      row,
      columns: columns?.call(ButlerMessage.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ButlerMessage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ButlerMessage>> delete(
    _i1.Session session,
    List<ButlerMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ButlerMessage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ButlerMessage].
  Future<ButlerMessage> deleteRow(
    _i1.Session session,
    ButlerMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ButlerMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ButlerMessage>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ButlerMessageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ButlerMessage>(
      where: where(ButlerMessage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ButlerMessageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ButlerMessage>(
      where: where?.call(ButlerMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
