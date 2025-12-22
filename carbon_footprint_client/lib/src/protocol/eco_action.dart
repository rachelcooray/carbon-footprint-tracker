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

abstract class EcoAction implements _i1.SerializableModel {
  EcoAction._({
    this.id,
    required this.name,
    required this.co2Factor,
    required this.unit,
    required this.category,
  });

  factory EcoAction({
    int? id,
    required String name,
    required double co2Factor,
    required String unit,
    required String category,
  }) = _EcoActionImpl;

  factory EcoAction.fromJson(Map<String, dynamic> jsonSerialization) {
    return EcoAction(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      co2Factor: (jsonSerialization['co2Factor'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      category: jsonSerialization['category'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  double co2Factor;

  String unit;

  String category;

  /// Returns a shallow copy of this [EcoAction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EcoAction copyWith({
    int? id,
    String? name,
    double? co2Factor,
    String? unit,
    String? category,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'co2Factor': co2Factor,
      'unit': unit,
      'category': category,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EcoActionImpl extends EcoAction {
  _EcoActionImpl({
    int? id,
    required String name,
    required double co2Factor,
    required String unit,
    required String category,
  }) : super._(
          id: id,
          name: name,
          co2Factor: co2Factor,
          unit: unit,
          category: category,
        );

  /// Returns a shallow copy of this [EcoAction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EcoAction copyWith({
    Object? id = _Undefined,
    String? name,
    double? co2Factor,
    String? unit,
    String? category,
  }) {
    return EcoAction(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      co2Factor: co2Factor ?? this.co2Factor,
      unit: unit ?? this.unit,
      category: category ?? this.category,
    );
  }
}
