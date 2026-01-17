/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Company implements _i1.SerializableModel {
  Company._({
    this.id,
    required this.name,
    this.description,
    required this.timezone,
    required this.reportFrequency,
    this.customFrequencyDays,
    required this.aiEnabled,
    required this.toneSetting,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Company({
    int? id,
    required String name,
    String? description,
    required String timezone,
    required String reportFrequency,
    int? customFrequencyDays,
    required bool aiEnabled,
    required String toneSetting,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CompanyImpl;

  factory Company.fromJson(Map<String, dynamic> jsonSerialization) {
    return Company(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      timezone: jsonSerialization['timezone'] as String,
      reportFrequency: jsonSerialization['reportFrequency'] as String,
      customFrequencyDays: jsonSerialization['customFrequencyDays'] as int?,
      aiEnabled: jsonSerialization['aiEnabled'] as bool,
      toneSetting: jsonSerialization['toneSetting'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? description;

  String timezone;

  String reportFrequency;

  int? customFrequencyDays;

  bool aiEnabled;

  String toneSetting;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Company]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Company copyWith({
    int? id,
    String? name,
    String? description,
    String? timezone,
    String? reportFrequency,
    int? customFrequencyDays,
    bool? aiEnabled,
    String? toneSetting,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Company',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'timezone': timezone,
      'reportFrequency': reportFrequency,
      if (customFrequencyDays != null)
        'customFrequencyDays': customFrequencyDays,
      'aiEnabled': aiEnabled,
      'toneSetting': toneSetting,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompanyImpl extends Company {
  _CompanyImpl({
    int? id,
    required String name,
    String? description,
    required String timezone,
    required String reportFrequency,
    int? customFrequencyDays,
    required bool aiEnabled,
    required String toneSetting,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         name: name,
         description: description,
         timezone: timezone,
         reportFrequency: reportFrequency,
         customFrequencyDays: customFrequencyDays,
         aiEnabled: aiEnabled,
         toneSetting: toneSetting,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Company]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Company copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    String? timezone,
    String? reportFrequency,
    Object? customFrequencyDays = _Undefined,
    bool? aiEnabled,
    String? toneSetting,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Company(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      timezone: timezone ?? this.timezone,
      reportFrequency: reportFrequency ?? this.reportFrequency,
      customFrequencyDays: customFrequencyDays is int?
          ? customFrequencyDays
          : this.customFrequencyDays,
      aiEnabled: aiEnabled ?? this.aiEnabled,
      toneSetting: toneSetting ?? this.toneSetting,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
