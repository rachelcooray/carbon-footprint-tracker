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
import 'challenge.dart' as _i2;

abstract class ChallengeProgress implements _i1.SerializableModel {
  ChallengeProgress._({
    required this.challenge,
    required this.currentAmount,
    required this.percentComplete,
  });

  factory ChallengeProgress({
    required _i2.Challenge challenge,
    required double currentAmount,
    required double percentComplete,
  }) = _ChallengeProgressImpl;

  factory ChallengeProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChallengeProgress(
      challenge: _i2.Challenge.fromJson(
          (jsonSerialization['challenge'] as Map<String, dynamic>)),
      currentAmount: (jsonSerialization['currentAmount'] as num).toDouble(),
      percentComplete: (jsonSerialization['percentComplete'] as num).toDouble(),
    );
  }

  _i2.Challenge challenge;

  double currentAmount;

  double percentComplete;

  /// Returns a shallow copy of this [ChallengeProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChallengeProgress copyWith({
    _i2.Challenge? challenge,
    double? currentAmount,
    double? percentComplete,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'challenge': challenge.toJson(),
      'currentAmount': currentAmount,
      'percentComplete': percentComplete,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ChallengeProgressImpl extends ChallengeProgress {
  _ChallengeProgressImpl({
    required _i2.Challenge challenge,
    required double currentAmount,
    required double percentComplete,
  }) : super._(
          challenge: challenge,
          currentAmount: currentAmount,
          percentComplete: percentComplete,
        );

  /// Returns a shallow copy of this [ChallengeProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChallengeProgress copyWith({
    _i2.Challenge? challenge,
    double? currentAmount,
    double? percentComplete,
  }) {
    return ChallengeProgress(
      challenge: challenge ?? this.challenge.copyWith(),
      currentAmount: currentAmount ?? this.currentAmount,
      percentComplete: percentComplete ?? this.percentComplete,
    );
  }
}
