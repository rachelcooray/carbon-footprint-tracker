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

abstract class ButlerEvent implements _i1.SerializableModel {
  ButlerEvent._({
    this.id,
    required this.userId,
    required this.type,
    required this.message,
    required this.timestamp,
    required this.isResolved,
  });

  factory ButlerEvent({
    int? id,
    required int userId,
    required String type,
    required String message,
    required DateTime timestamp,
    required bool isResolved,
  }) = _ButlerEventImpl;

  factory ButlerEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return ButlerEvent(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      type: jsonSerialization['type'] as String,
      message: jsonSerialization['message'] as String,
      timestamp:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      isResolved: jsonSerialization['isResolved'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String type;

  String message;

  DateTime timestamp;

  bool isResolved;

  /// Returns a shallow copy of this [ButlerEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ButlerEvent copyWith({
    int? id,
    int? userId,
    String? type,
    String? message,
    DateTime? timestamp,
    bool? isResolved,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'type': type,
      'message': message,
      'timestamp': timestamp.toJson(),
      'isResolved': isResolved,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ButlerEventImpl extends ButlerEvent {
  _ButlerEventImpl({
    int? id,
    required int userId,
    required String type,
    required String message,
    required DateTime timestamp,
    required bool isResolved,
  }) : super._(
          id: id,
          userId: userId,
          type: type,
          message: message,
          timestamp: timestamp,
          isResolved: isResolved,
        );

  /// Returns a shallow copy of this [ButlerEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ButlerEvent copyWith({
    Object? id = _Undefined,
    int? userId,
    String? type,
    String? message,
    DateTime? timestamp,
    bool? isResolved,
  }) {
    return ButlerEvent(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isResolved: isResolved ?? this.isResolved,
    );
  }
}
