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

abstract class Challenge implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String description;

  int targetActionId;

  _i2.EcoAction? targetAction;

  double targetAmount;

  String unit;

  int points;

  int durationDays;

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
