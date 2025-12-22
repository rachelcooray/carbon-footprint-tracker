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

abstract class ButlerMessage implements _i1.SerializableModel {
  ButlerMessage._({
    this.id,
    required this.userId,
    required this.text,
    required this.isFromButler,
    required this.timestamp,
  });

  factory ButlerMessage({
    int? id,
    required int userId,
    required String text,
    required bool isFromButler,
    required DateTime timestamp,
  }) = _ButlerMessageImpl;

  factory ButlerMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ButlerMessage(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      text: jsonSerialization['text'] as String,
      isFromButler: jsonSerialization['isFromButler'] as bool,
      timestamp:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String text;

  bool isFromButler;

  DateTime timestamp;

  /// Returns a shallow copy of this [ButlerMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ButlerMessage copyWith({
    int? id,
    int? userId,
    String? text,
    bool? isFromButler,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'text': text,
      'isFromButler': isFromButler,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ButlerMessageImpl extends ButlerMessage {
  _ButlerMessageImpl({
    int? id,
    required int userId,
    required String text,
    required bool isFromButler,
    required DateTime timestamp,
  }) : super._(
          id: id,
          userId: userId,
          text: text,
          isFromButler: isFromButler,
          timestamp: timestamp,
        );

  /// Returns a shallow copy of this [ButlerMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ButlerMessage copyWith({
    Object? id = _Undefined,
    int? userId,
    String? text,
    bool? isFromButler,
    DateTime? timestamp,
  }) {
    return ButlerMessage(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      text: text ?? this.text,
      isFromButler: isFromButler ?? this.isFromButler,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
