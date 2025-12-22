/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'eco_action.dart' as _i2;

abstract class ActionLog implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  DateTime date;

  int actionId;

  _i2.EcoAction? action;

  double quantity;

  double co2Saved;

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
