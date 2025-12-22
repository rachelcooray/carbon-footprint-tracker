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

abstract class Challenge
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Challenge._({
    this.id,
    required this.title,
    required this.description,
    required this.targetActionId,
    this.targetAction,
    required this.targetAmount,
    required this.unit,
    required this.points,
    required this.durationDays,
  });

  factory Challenge({
    int? id,
    required String title,
    required String description,
    required int targetActionId,
    _i2.EcoAction? targetAction,
    required double targetAmount,
    required String unit,
    required int points,
    required int durationDays,
  }) = _ChallengeImpl;

  factory Challenge.fromJson(Map<String, dynamic> jsonSerialization) {
    return Challenge(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      targetActionId: jsonSerialization['targetActionId'] as int,
      targetAction: jsonSerialization['targetAction'] == null
          ? null
          : _i2.EcoAction.fromJson(
              (jsonSerialization['targetAction'] as Map<String, dynamic>)),
      targetAmount: (jsonSerialization['targetAmount'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      points: jsonSerialization['points'] as int,
      durationDays: jsonSerialization['durationDays'] as int,
    );
  }

  static final t = ChallengeTable();

  static const db = ChallengeRepository._();

  @override
  int? id;

  String title;

  String description;

  int targetActionId;

  _i2.EcoAction? targetAction;

  double targetAmount;

  String unit;

  int points;

  int durationDays;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Challenge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Challenge copyWith({
    int? id,
    String? title,
    String? description,
    int? targetActionId,
    _i2.EcoAction? targetAction,
    double? targetAmount,
    String? unit,
    int? points,
    int? durationDays,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'targetActionId': targetActionId,
      if (targetAction != null) 'targetAction': targetAction?.toJson(),
      'targetAmount': targetAmount,
      'unit': unit,
      'points': points,
      'durationDays': durationDays,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'targetActionId': targetActionId,
      if (targetAction != null)
        'targetAction': targetAction?.toJsonForProtocol(),
      'targetAmount': targetAmount,
      'unit': unit,
      'points': points,
      'durationDays': durationDays,
    };
  }

  static ChallengeInclude include({_i2.EcoActionInclude? targetAction}) {
    return ChallengeInclude._(targetAction: targetAction);
  }

  static ChallengeIncludeList includeList({
    _i1.WhereExpressionBuilder<ChallengeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTable>? orderByList,
    ChallengeInclude? include,
  }) {
    return ChallengeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Challenge.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Challenge.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeImpl extends Challenge {
  _ChallengeImpl({
    int? id,
    required String title,
    required String description,
    required int targetActionId,
    _i2.EcoAction? targetAction,
    required double targetAmount,
    required String unit,
    required int points,
    required int durationDays,
  }) : super._(
          id: id,
          title: title,
          description: description,
          targetActionId: targetActionId,
          targetAction: targetAction,
          targetAmount: targetAmount,
          unit: unit,
          points: points,
          durationDays: durationDays,
        );

  /// Returns a shallow copy of this [Challenge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Challenge copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    int? targetActionId,
    Object? targetAction = _Undefined,
    double? targetAmount,
    String? unit,
    int? points,
    int? durationDays,
  }) {
    return Challenge(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      targetActionId: targetActionId ?? this.targetActionId,
      targetAction: targetAction is _i2.EcoAction?
          ? targetAction
          : this.targetAction?.copyWith(),
      targetAmount: targetAmount ?? this.targetAmount,
      unit: unit ?? this.unit,
      points: points ?? this.points,
      durationDays: durationDays ?? this.durationDays,
    );
  }
}

class ChallengeTable extends _i1.Table<int?> {
  ChallengeTable({super.tableRelation}) : super(tableName: 'challenge') {
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    targetActionId = _i1.ColumnInt(
      'targetActionId',
      this,
    );
    targetAmount = _i1.ColumnDouble(
      'targetAmount',
      this,
    );
    unit = _i1.ColumnString(
      'unit',
      this,
    );
    points = _i1.ColumnInt(
      'points',
      this,
    );
    durationDays = _i1.ColumnInt(
      'durationDays',
      this,
    );
  }

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt targetActionId;

  _i2.EcoActionTable? _targetAction;

  late final _i1.ColumnDouble targetAmount;

  late final _i1.ColumnString unit;

  late final _i1.ColumnInt points;

  late final _i1.ColumnInt durationDays;

  _i2.EcoActionTable get targetAction {
    if (_targetAction != null) return _targetAction!;
    _targetAction = _i1.createRelationTable(
      relationFieldName: 'targetAction',
      field: Challenge.t.targetActionId,
      foreignField: _i2.EcoAction.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.EcoActionTable(tableRelation: foreignTableRelation),
    );
    return _targetAction!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        title,
        description,
        targetActionId,
        targetAmount,
        unit,
        points,
        durationDays,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'targetAction') {
      return targetAction;
    }
    return null;
  }
}

class ChallengeInclude extends _i1.IncludeObject {
  ChallengeInclude._({_i2.EcoActionInclude? targetAction}) {
    _targetAction = targetAction;
  }

  _i2.EcoActionInclude? _targetAction;

  @override
  Map<String, _i1.Include?> get includes => {'targetAction': _targetAction};

  @override
  _i1.Table<int?> get table => Challenge.t;
}

class ChallengeIncludeList extends _i1.IncludeList {
  ChallengeIncludeList._({
    _i1.WhereExpressionBuilder<ChallengeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Challenge.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Challenge.t;
}

class ChallengeRepository {
  const ChallengeRepository._();

  final attachRow = const ChallengeAttachRowRepository._();

  /// Returns a list of [Challenge]s matching the given query parameters.
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
  Future<List<Challenge>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChallengeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTable>? orderByList,
    _i1.Transaction? transaction,
    ChallengeInclude? include,
  }) async {
    return session.db.find<Challenge>(
      where: where?.call(Challenge.t),
      orderBy: orderBy?.call(Challenge.t),
      orderByList: orderByList?.call(Challenge.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Challenge] matching the given query parameters.
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
  Future<Challenge?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChallengeTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChallengeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTable>? orderByList,
    _i1.Transaction? transaction,
    ChallengeInclude? include,
  }) async {
    return session.db.findFirstRow<Challenge>(
      where: where?.call(Challenge.t),
      orderBy: orderBy?.call(Challenge.t),
      orderByList: orderByList?.call(Challenge.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Challenge] by its [id] or null if no such row exists.
  Future<Challenge?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ChallengeInclude? include,
  }) async {
    return session.db.findById<Challenge>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Challenge]s in the list and returns the inserted rows.
  ///
  /// The returned [Challenge]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Challenge>> insert(
    _i1.Session session,
    List<Challenge> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Challenge>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Challenge] and returns the inserted row.
  ///
  /// The returned [Challenge] will have its `id` field set.
  Future<Challenge> insertRow(
    _i1.Session session,
    Challenge row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Challenge>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Challenge]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Challenge>> update(
    _i1.Session session,
    List<Challenge> rows, {
    _i1.ColumnSelections<ChallengeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Challenge>(
      rows,
      columns: columns?.call(Challenge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Challenge]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Challenge> updateRow(
    _i1.Session session,
    Challenge row, {
    _i1.ColumnSelections<ChallengeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Challenge>(
      row,
      columns: columns?.call(Challenge.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Challenge]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Challenge>> delete(
    _i1.Session session,
    List<Challenge> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Challenge>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Challenge].
  Future<Challenge> deleteRow(
    _i1.Session session,
    Challenge row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Challenge>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Challenge>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChallengeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Challenge>(
      where: where(Challenge.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChallengeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Challenge>(
      where: where?.call(Challenge.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ChallengeAttachRowRepository {
  const ChallengeAttachRowRepository._();

  /// Creates a relation between the given [Challenge] and [EcoAction]
  /// by setting the [Challenge]'s foreign key `targetActionId` to refer to the [EcoAction].
  Future<void> targetAction(
    _i1.Session session,
    Challenge challenge,
    _i2.EcoAction targetAction, {
    _i1.Transaction? transaction,
  }) async {
    if (challenge.id == null) {
      throw ArgumentError.notNull('challenge.id');
    }
    if (targetAction.id == null) {
      throw ArgumentError.notNull('targetAction.id');
    }

    var $challenge = challenge.copyWith(targetActionId: targetAction.id);
    await session.db.updateRow<Challenge>(
      $challenge,
      columns: [Challenge.t.targetActionId],
      transaction: transaction,
    );
  }
}
