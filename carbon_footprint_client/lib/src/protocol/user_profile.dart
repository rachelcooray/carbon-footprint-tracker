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

abstract class UserProfile implements _i1.SerializableModel {
  UserProfile._({
    this.id,
    required this.userId,
    required this.ecoScore,
    required this.joinedDate,
    int? level,
    int? streakDays,
    this.lastActionDate,
    double? monthlyBudget,
  })  : level = level ?? 1,
        streakDays = streakDays ?? 0,
        monthlyBudget = monthlyBudget ?? 200.0;

  factory UserProfile({
    int? id,
    required int userId,
    required int ecoScore,
    required DateTime joinedDate,
    int? level,
    int? streakDays,
    DateTime? lastActionDate,
    double? monthlyBudget,
  }) = _UserProfileImpl;

  factory UserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      ecoScore: jsonSerialization['ecoScore'] as int,
      joinedDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['joinedDate']),
      level: jsonSerialization['level'] as int,
      streakDays: jsonSerialization['streakDays'] as int,
      lastActionDate: jsonSerialization['lastActionDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastActionDate']),
      monthlyBudget: (jsonSerialization['monthlyBudget'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int ecoScore;

  DateTime joinedDate;

  int level;

  int streakDays;

  DateTime? lastActionDate;

  double monthlyBudget;

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserProfile copyWith({
    int? id,
    int? userId,
    int? ecoScore,
    DateTime? joinedDate,
    int? level,
    int? streakDays,
    DateTime? lastActionDate,
    double? monthlyBudget,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'ecoScore': ecoScore,
      'joinedDate': joinedDate.toJson(),
      'level': level,
      'streakDays': streakDays,
      if (lastActionDate != null) 'lastActionDate': lastActionDate?.toJson(),
      'monthlyBudget': monthlyBudget,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserProfileImpl extends UserProfile {
  _UserProfileImpl({
    int? id,
    required int userId,
    required int ecoScore,
    required DateTime joinedDate,
    int? level,
    int? streakDays,
    DateTime? lastActionDate,
    double? monthlyBudget,
  }) : super._(
          id: id,
          userId: userId,
          ecoScore: ecoScore,
          joinedDate: joinedDate,
          level: level,
          streakDays: streakDays,
          lastActionDate: lastActionDate,
          monthlyBudget: monthlyBudget,
        );

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserProfile copyWith({
    Object? id = _Undefined,
    int? userId,
    int? ecoScore,
    DateTime? joinedDate,
    int? level,
    int? streakDays,
    Object? lastActionDate = _Undefined,
    double? monthlyBudget,
  }) {
    return UserProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      ecoScore: ecoScore ?? this.ecoScore,
      joinedDate: joinedDate ?? this.joinedDate,
      level: level ?? this.level,
      streakDays: streakDays ?? this.streakDays,
      lastActionDate:
          lastActionDate is DateTime? ? lastActionDate : this.lastActionDate,
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
    );
  }
}
