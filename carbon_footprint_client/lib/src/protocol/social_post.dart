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

abstract class SocialPost implements _i1.SerializableModel {
  SocialPost._({
    this.id,
    required this.userId,
    this.userName,
    required this.content,
    required this.timestamp,
    required this.type,
  });

  factory SocialPost({
    int? id,
    required int userId,
    String? userName,
    required String content,
    required DateTime timestamp,
    required String type,
  }) = _SocialPostImpl;

  factory SocialPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return SocialPost(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      userName: jsonSerialization['userName'] as String?,
      content: jsonSerialization['content'] as String,
      timestamp:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      type: jsonSerialization['type'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String? userName;

  String content;

  DateTime timestamp;

  String type;

  /// Returns a shallow copy of this [SocialPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SocialPost copyWith({
    int? id,
    int? userId,
    String? userName,
    String? content,
    DateTime? timestamp,
    String? type,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (userName != null) 'userName': userName,
      'content': content,
      'timestamp': timestamp.toJson(),
      'type': type,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SocialPostImpl extends SocialPost {
  _SocialPostImpl({
    int? id,
    required int userId,
    String? userName,
    required String content,
    required DateTime timestamp,
    required String type,
  }) : super._(
          id: id,
          userId: userId,
          userName: userName,
          content: content,
          timestamp: timestamp,
          type: type,
        );

  /// Returns a shallow copy of this [SocialPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SocialPost copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? userName = _Undefined,
    String? content,
    DateTime? timestamp,
    String? type,
  }) {
    return SocialPost(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      userName: userName is String? ? userName : this.userName,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
    );
  }
}
