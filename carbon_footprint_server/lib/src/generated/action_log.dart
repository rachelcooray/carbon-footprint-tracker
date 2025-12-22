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
import 'eco_action.dart' as _i2;

abstract class ActionLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ActionLog._({
    this.id,
    required this.userId,
    required this.date,
    required this.actionId,
    this.action,
    required this.quantity,
    required this.co2Saved,
  });

  factory ActionLog({
    int? id,
    required int userId,
    required DateTime date,
    required int actionId,
    _i2.EcoAction? action,
    required double quantity,
    required double co2Saved,
  }) = _ActionLogImpl;

  factory ActionLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActionLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      actionId: jsonSerialization['actionId'] as int,
      action: jsonSerialization['action'] == null
          ? null
          : _i2.EcoAction.fromJson(
              (jsonSerialization['action'] as Map<String, dynamic>)),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      co2Saved: (jsonSerialization['co2Saved'] as num).toDouble(),
    );
  }

  static final t = ActionLogTable();

  static const db = ActionLogRepository._();

  @override
  int? id;

  int userId;

  DateTime date;

  int actionId;

  _i2.EcoAction? action;

  double quantity;

  double co2Saved;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ActionLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ActionLog copyWith({
    int? id,
    int? userId,
    DateTime? date,
    int? actionId,
    _i2.EcoAction? action,
    double? quantity,
    double? co2Saved,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'date': date.toJson(),
      'actionId': actionId,
      if (action != null) 'action': action?.toJson(),
      'quantity': quantity,
      'co2Saved': co2Saved,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'date': date.toJson(),
      'actionId': actionId,
      if (action != null) 'action': action?.toJsonForProtocol(),
      'quantity': quantity,
      'co2Saved': co2Saved,
    };
  }

  static ActionLogInclude include({_i2.EcoActionInclude? action}) {
    return ActionLogInclude._(action: action);
  }

  static ActionLogIncludeList includeList({
    _i1.WhereExpressionBuilder<ActionLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ActionLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActionLogTable>? orderByList,
    ActionLogInclude? include,
  }) {
    return ActionLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActionLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ActionLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActionLogImpl extends ActionLog {
  _ActionLogImpl({
    int? id,
    required int userId,
    required DateTime date,
    required int actionId,
    _i2.EcoAction? action,
    required double quantity,
    required double co2Saved,
  }) : super._(
          id: id,
          userId: userId,
          date: date,
          actionId: actionId,
          action: action,
          quantity: quantity,
          co2Saved: co2Saved,
        );

  /// Returns a shallow copy of this [ActionLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ActionLog copyWith({
    Object? id = _Undefined,
    int? userId,
    DateTime? date,
    int? actionId,
    Object? action = _Undefined,
    double? quantity,
    double? co2Saved,
  }) {
    return ActionLog(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      actionId: actionId ?? this.actionId,
      action: action is _i2.EcoAction? ? action : this.action?.copyWith(),
      quantity: quantity ?? this.quantity,
      co2Saved: co2Saved ?? this.co2Saved,
    );
  }
}

class ActionLogTable extends _i1.Table<int?> {
  ActionLogTable({super.tableRelation}) : super(tableName: 'action_log') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    actionId = _i1.ColumnInt(
      'actionId',
      this,
    );
    quantity = _i1.ColumnDouble(
      'quantity',
      this,
    );
    co2Saved = _i1.ColumnDouble(
      'co2Saved',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnInt actionId;

  _i2.EcoActionTable? _action;

  late final _i1.ColumnDouble quantity;

  late final _i1.ColumnDouble co2Saved;

  _i2.EcoActionTable get action {
    if (_action != null) return _action!;
    _action = _i1.createRelationTable(
      relationFieldName: 'action',
      field: ActionLog.t.actionId,
      foreignField: _i2.EcoAction.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.EcoActionTable(tableRelation: foreignTableRelation),
    );
    return _action!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        date,
        actionId,
        quantity,
        co2Saved,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'action') {
      return action;
    }
    return null;
  }
}

class ActionLogInclude extends _i1.IncludeObject {
  ActionLogInclude._({_i2.EcoActionInclude? action}) {
    _action = action;
  }

  _i2.EcoActionInclude? _action;

  @override
  Map<String, _i1.Include?> get includes => {'action': _action};

  @override
  _i1.Table<int?> get table => ActionLog.t;
}

class ActionLogIncludeList extends _i1.IncludeList {
  ActionLogIncludeList._({
    _i1.WhereExpressionBuilder<ActionLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ActionLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ActionLog.t;
}

class ActionLogRepository {
  const ActionLogRepository._();

  final attachRow = const ActionLogAttachRowRepository._();

  /// Returns a list of [ActionLog]s matching the given query parameters.
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
  Future<List<ActionLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActionLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ActionLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActionLogTable>? orderByList,
    _i1.Transaction? transaction,
    ActionLogInclude? include,
  }) async {
    return session.db.find<ActionLog>(
      where: where?.call(ActionLog.t),
      orderBy: orderBy?.call(ActionLog.t),
      orderByList: orderByList?.call(ActionLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ActionLog] matching the given query parameters.
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
  Future<ActionLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActionLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<ActionLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActionLogTable>? orderByList,
    _i1.Transaction? transaction,
    ActionLogInclude? include,
  }) async {
    return session.db.findFirstRow<ActionLog>(
      where: where?.call(ActionLog.t),
      orderBy: orderBy?.call(ActionLog.t),
      orderByList: orderByList?.call(ActionLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ActionLog] by its [id] or null if no such row exists.
  Future<ActionLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ActionLogInclude? include,
  }) async {
    return session.db.findById<ActionLog>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ActionLog]s in the list and returns the inserted rows.
  ///
  /// The returned [ActionLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ActionLog>> insert(
    _i1.Session session,
    List<ActionLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ActionLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ActionLog] and returns the inserted row.
  ///
  /// The returned [ActionLog] will have its `id` field set.
  Future<ActionLog> insertRow(
    _i1.Session session,
    ActionLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ActionLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ActionLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ActionLog>> update(
    _i1.Session session,
    List<ActionLog> rows, {
    _i1.ColumnSelections<ActionLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ActionLog>(
      rows,
      columns: columns?.call(ActionLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ActionLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ActionLog> updateRow(
    _i1.Session session,
    ActionLog row, {
    _i1.ColumnSelections<ActionLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ActionLog>(
      row,
      columns: columns?.call(ActionLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ActionLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ActionLog>> delete(
    _i1.Session session,
    List<ActionLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ActionLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ActionLog].
  Future<ActionLog> deleteRow(
    _i1.Session session,
    ActionLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ActionLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ActionLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ActionLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ActionLog>(
      where: where(ActionLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActionLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ActionLog>(
      where: where?.call(ActionLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ActionLogAttachRowRepository {
  const ActionLogAttachRowRepository._();

  /// Creates a relation between the given [ActionLog] and [EcoAction]
  /// by setting the [ActionLog]'s foreign key `actionId` to refer to the [EcoAction].
  Future<void> action(
    _i1.Session session,
    ActionLog actionLog,
    _i2.EcoAction action, {
    _i1.Transaction? transaction,
  }) async {
    if (actionLog.id == null) {
      throw ArgumentError.notNull('actionLog.id');
    }
    if (action.id == null) {
      throw ArgumentError.notNull('action.id');
    }

    var $actionLog = actionLog.copyWith(actionId: action.id);
    await session.db.updateRow<ActionLog>(
      $actionLog,
      columns: [ActionLog.t.actionId],
      transaction: transaction,
    );
  }
}
