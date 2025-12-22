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

abstract class Badge implements _i1.SerializableModel {
  Badge._({
    this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.earnedDate,
    this.iconType,
  });

  factory Badge({
    int? id,
    required int userId,
    required String name,
    required String description,
    required DateTime earnedDate,
    String? iconType,
  }) = _BadgeImpl;

  factory Badge.fromJson(Map<String, dynamic> jsonSerialization) {
    return Badge(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      earnedDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['earnedDate']),
      iconType: jsonSerialization['iconType'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String name;

  String description;

  DateTime earnedDate;

  String? iconType;

  /// Returns a shallow copy of this [Badge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Badge copyWith({
    int? id,
    int? userId,
    String? name,
    String? description,
    DateTime? earnedDate,
    String? iconType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'earnedDate': earnedDate.toJson(),
      if (iconType != null) 'iconType': iconType,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BadgeImpl extends Badge {
  _BadgeImpl({
    int? id,
    required int userId,
    required String name,
    required String description,
    required DateTime earnedDate,
    String? iconType,
  }) : super._(
          id: id,
          userId: userId,
          name: name,
          description: description,
          earnedDate: earnedDate,
          iconType: iconType,
        );

  /// Returns a shallow copy of this [Badge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Badge copyWith({
    Object? id = _Undefined,
    int? userId,
    String? name,
    String? description,
    DateTime? earnedDate,
    Object? iconType = _Undefined,
  }) {
    return Badge(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      earnedDate: earnedDate ?? this.earnedDate,
      iconType: iconType is String? ? iconType : this.iconType,
    );
  }
}
