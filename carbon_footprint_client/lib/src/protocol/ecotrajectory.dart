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

abstract class Ecotrajectory implements _i1.SerializableModel {
  Ecotrajectory._({
    required this.netZeroDate,
    required this.savingsRate,
    required this.isAchievable,
    required this.daysToNetZero,
    required this.currentCarbonDebt,
  });

  factory Ecotrajectory({
    required DateTime netZeroDate,
    required double savingsRate,
    required bool isAchievable,
    required int daysToNetZero,
    required double currentCarbonDebt,
  }) = _EcotrajectoryImpl;

  factory Ecotrajectory.fromJson(Map<String, dynamic> jsonSerialization) {
    return Ecotrajectory(
      netZeroDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['netZeroDate']),
      savingsRate: (jsonSerialization['savingsRate'] as num).toDouble(),
      isAchievable: jsonSerialization['isAchievable'] as bool,
      daysToNetZero: jsonSerialization['daysToNetZero'] as int,
      currentCarbonDebt:
          (jsonSerialization['currentCarbonDebt'] as num).toDouble(),
    );
  }

  DateTime netZeroDate;

  double savingsRate;

  bool isAchievable;

  int daysToNetZero;

  double currentCarbonDebt;

  /// Returns a shallow copy of this [Ecotrajectory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Ecotrajectory copyWith({
    DateTime? netZeroDate,
    double? savingsRate,
    bool? isAchievable,
    int? daysToNetZero,
    double? currentCarbonDebt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'netZeroDate': netZeroDate.toJson(),
      'savingsRate': savingsRate,
      'isAchievable': isAchievable,
      'daysToNetZero': daysToNetZero,
      'currentCarbonDebt': currentCarbonDebt,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EcotrajectoryImpl extends Ecotrajectory {
  _EcotrajectoryImpl({
    required DateTime netZeroDate,
    required double savingsRate,
    required bool isAchievable,
    required int daysToNetZero,
    required double currentCarbonDebt,
  }) : super._(
          netZeroDate: netZeroDate,
          savingsRate: savingsRate,
          isAchievable: isAchievable,
          daysToNetZero: daysToNetZero,
          currentCarbonDebt: currentCarbonDebt,
        );

  /// Returns a shallow copy of this [Ecotrajectory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Ecotrajectory copyWith({
    DateTime? netZeroDate,
    double? savingsRate,
    bool? isAchievable,
    int? daysToNetZero,
    double? currentCarbonDebt,
  }) {
    return Ecotrajectory(
      netZeroDate: netZeroDate ?? this.netZeroDate,
      savingsRate: savingsRate ?? this.savingsRate,
      isAchievable: isAchievable ?? this.isAchievable,
      daysToNetZero: daysToNetZero ?? this.daysToNetZero,
      currentCarbonDebt: currentCarbonDebt ?? this.currentCarbonDebt,
    );
  }
}
