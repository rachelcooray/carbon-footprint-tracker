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

abstract class EcoAction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  EcoAction._({
    this.id,
    required this.name,
    required this.co2Factor,
    required this.unit,
    required this.category,
  });

  factory EcoAction({
    int? id,
    required String name,
    required double co2Factor,
    required String unit,
    required String category,
  }) = _EcoActionImpl;

  factory EcoAction.fromJson(Map<String, dynamic> jsonSerialization) {
    return EcoAction(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      co2Factor: (jsonSerialization['co2Factor'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      category: jsonSerialization['category'] as String,
    );
  }

  static final t = EcoActionTable();

  static const db = EcoActionRepository._();

  @override
  int? id;

  String name;

  double co2Factor;

  String unit;

  String category;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [EcoAction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EcoAction copyWith({
    int? id,
    String? name,
    double? co2Factor,
    String? unit,
    String? category,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'co2Factor': co2Factor,
      'unit': unit,
      'category': category,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'co2Factor': co2Factor,
      'unit': unit,
      'category': category,
    };
  }

  static EcoActionInclude include() {
    return EcoActionInclude._();
  }

  static EcoActionIncludeList includeList({
    _i1.WhereExpressionBuilder<EcoActionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EcoActionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EcoActionTable>? orderByList,
    EcoActionInclude? include,
  }) {
    return EcoActionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EcoAction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EcoAction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EcoActionImpl extends EcoAction {
  _EcoActionImpl({
    int? id,
    required String name,
    required double co2Factor,
    required String unit,
    required String category,
  }) : super._(
          id: id,
          name: name,
          co2Factor: co2Factor,
          unit: unit,
          category: category,
        );

  /// Returns a shallow copy of this [EcoAction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EcoAction copyWith({
    Object? id = _Undefined,
    String? name,
    double? co2Factor,
    String? unit,
    String? category,
  }) {
    return EcoAction(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      co2Factor: co2Factor ?? this.co2Factor,
      unit: unit ?? this.unit,
      category: category ?? this.category,
    );
  }
}

class EcoActionTable extends _i1.Table<int?> {
  EcoActionTable({super.tableRelation}) : super(tableName: 'eco_action') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    co2Factor = _i1.ColumnDouble(
      'co2Factor',
      this,
    );
    unit = _i1.ColumnString(
      'unit',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnDouble co2Factor;

  late final _i1.ColumnString unit;

  late final _i1.ColumnString category;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        co2Factor,
        unit,
        category,
      ];
}

class EcoActionInclude extends _i1.IncludeObject {
  EcoActionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => EcoAction.t;
}

class EcoActionIncludeList extends _i1.IncludeList {
  EcoActionIncludeList._({
    _i1.WhereExpressionBuilder<EcoActionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EcoAction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => EcoAction.t;
}

class EcoActionRepository {
  const EcoActionRepository._();

  /// Returns a list of [EcoAction]s matching the given query parameters.
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
  Future<List<EcoAction>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EcoActionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EcoActionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EcoActionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<EcoAction>(
      where: where?.call(EcoAction.t),
      orderBy: orderBy?.call(EcoAction.t),
      orderByList: orderByList?.call(EcoAction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [EcoAction] matching the given query parameters.
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
  Future<EcoAction?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EcoActionTable>? where,
    int? offset,
    _i1.OrderByBuilder<EcoActionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EcoActionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<EcoAction>(
      where: where?.call(EcoAction.t),
      orderBy: orderBy?.call(EcoAction.t),
      orderByList: orderByList?.call(EcoAction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [EcoAction] by its [id] or null if no such row exists.
  Future<EcoAction?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<EcoAction>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [EcoAction]s in the list and returns the inserted rows.
  ///
  /// The returned [EcoAction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<EcoAction>> insert(
    _i1.Session session,
    List<EcoAction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<EcoAction>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [EcoAction] and returns the inserted row.
  ///
  /// The returned [EcoAction] will have its `id` field set.
  Future<EcoAction> insertRow(
    _i1.Session session,
    EcoAction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EcoAction>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EcoAction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EcoAction>> update(
    _i1.Session session,
    List<EcoAction> rows, {
    _i1.ColumnSelections<EcoActionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EcoAction>(
      rows,
      columns: columns?.call(EcoAction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EcoAction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EcoAction> updateRow(
    _i1.Session session,
    EcoAction row, {
    _i1.ColumnSelections<EcoActionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EcoAction>(
      row,
      columns: columns?.call(EcoAction.t),
      transaction: transaction,
    );
  }

  /// Deletes all [EcoAction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EcoAction>> delete(
    _i1.Session session,
    List<EcoAction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EcoAction>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EcoAction].
  Future<EcoAction> deleteRow(
    _i1.Session session,
    EcoAction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EcoAction>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EcoAction>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<EcoActionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EcoAction>(
      where: where(EcoAction.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EcoActionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EcoAction>(
      where: where?.call(EcoAction.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
