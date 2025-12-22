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

abstract class UserStats
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UserStats._({
    required this.totalCo2Saved,
    required this.weeklyCo2Saved,
    required this.ecoScore,
    required this.level,
    required this.streakDays,
    required this.monthlyBudget,
    required this.monthlyCo2Saved,
  });

  factory UserStats({
    required double totalCo2Saved,
    required double weeklyCo2Saved,
    required int ecoScore,
    required int level,
    required int streakDays,
    required double monthlyBudget,
    required double monthlyCo2Saved,
  }) = _UserStatsImpl;

  factory UserStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserStats(
      totalCo2Saved: (jsonSerialization['totalCo2Saved'] as num).toDouble(),
      weeklyCo2Saved: (jsonSerialization['weeklyCo2Saved'] as num).toDouble(),
      ecoScore: jsonSerialization['ecoScore'] as int,
      level: jsonSerialization['level'] as int,
      streakDays: jsonSerialization['streakDays'] as int,
      monthlyBudget: (jsonSerialization['monthlyBudget'] as num).toDouble(),
      monthlyCo2Saved: (jsonSerialization['monthlyCo2Saved'] as num).toDouble(),
    );
  }

  double totalCo2Saved;

  double weeklyCo2Saved;

  int ecoScore;

  int level;

  int streakDays;

  double monthlyBudget;

  double monthlyCo2Saved;

  /// Returns a shallow copy of this [UserStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserStats copyWith({
    double? totalCo2Saved,
    double? weeklyCo2Saved,
    int? ecoScore,
    int? level,
    int? streakDays,
    double? monthlyBudget,
    double? monthlyCo2Saved,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'totalCo2Saved': totalCo2Saved,
      'weeklyCo2Saved': weeklyCo2Saved,
      'ecoScore': ecoScore,
      'level': level,
      'streakDays': streakDays,
      'monthlyBudget': monthlyBudget,
      'monthlyCo2Saved': monthlyCo2Saved,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'totalCo2Saved': totalCo2Saved,
      'weeklyCo2Saved': weeklyCo2Saved,
      'ecoScore': ecoScore,
      'level': level,
      'streakDays': streakDays,
      'monthlyBudget': monthlyBudget,
      'monthlyCo2Saved': monthlyCo2Saved,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserStatsImpl extends UserStats {
  _UserStatsImpl({
    required double totalCo2Saved,
    required double weeklyCo2Saved,
    required int ecoScore,
    required int level,
    required int streakDays,
    required double monthlyBudget,
    required double monthlyCo2Saved,
  }) : super._(
          totalCo2Saved: totalCo2Saved,
          weeklyCo2Saved: weeklyCo2Saved,
          ecoScore: ecoScore,
          level: level,
          streakDays: streakDays,
          monthlyBudget: monthlyBudget,
          monthlyCo2Saved: monthlyCo2Saved,
        );

  /// Returns a shallow copy of this [UserStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserStats copyWith({
    double? totalCo2Saved,
    double? weeklyCo2Saved,
    int? ecoScore,
    int? level,
    int? streakDays,
    double? monthlyBudget,
    double? monthlyCo2Saved,
  }) {
    return UserStats(
      totalCo2Saved: totalCo2Saved ?? this.totalCo2Saved,
      weeklyCo2Saved: weeklyCo2Saved ?? this.weeklyCo2Saved,
      ecoScore: ecoScore ?? this.ecoScore,
      level: level ?? this.level,
      streakDays: streakDays ?? this.streakDays,
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
      monthlyCo2Saved: monthlyCo2Saved ?? this.monthlyCo2Saved,
    );
  }
}
