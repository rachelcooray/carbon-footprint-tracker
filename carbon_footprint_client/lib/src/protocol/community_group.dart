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

abstract class CommunityGroup implements _i1.SerializableModel {
  CommunityGroup._({
    this.id,
    required this.name,
    required this.description,
    double? totalImpact,
    int? memberCount,
  })  : totalImpact = totalImpact ?? 0.0,
        memberCount = memberCount ?? 0;

  factory CommunityGroup({
    int? id,
    required String name,
    required String description,
    double? totalImpact,
    int? memberCount,
  }) = _CommunityGroupImpl;

  factory CommunityGroup.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommunityGroup(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      totalImpact: (jsonSerialization['totalImpact'] as num).toDouble(),
      memberCount: jsonSerialization['memberCount'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String description;

  double totalImpact;

  int memberCount;

  /// Returns a shallow copy of this [CommunityGroup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommunityGroup copyWith({
    int? id,
    String? name,
    String? description,
    double? totalImpact,
    int? memberCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'totalImpact': totalImpact,
      'memberCount': memberCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommunityGroupImpl extends CommunityGroup {
  _CommunityGroupImpl({
    int? id,
    required String name,
    required String description,
    double? totalImpact,
    int? memberCount,
  }) : super._(
          id: id,
          name: name,
          description: description,
          totalImpact: totalImpact,
          memberCount: memberCount,
        );

  /// Returns a shallow copy of this [CommunityGroup]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommunityGroup copyWith({
    Object? id = _Undefined,
    String? name,
    String? description,
    double? totalImpact,
    int? memberCount,
  }) {
    return CommunityGroup(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      totalImpact: totalImpact ?? this.totalImpact,
      memberCount: memberCount ?? this.memberCount,
    );
  }
}
