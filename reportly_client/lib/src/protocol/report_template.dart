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

abstract class ReportTemplate implements _i1.SerializableModel {
  ReportTemplate._({
    this.id,
    required this.companyId,
    required this.name,
    required this.content,
    required this.isDefault,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportTemplate({
    int? id,
    required int companyId,
    required String name,
    required String content,
    required bool isDefault,
    required int version,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ReportTemplateImpl;

  factory ReportTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReportTemplate(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      name: jsonSerialization['name'] as String,
      content: jsonSerialization['content'] as String,
      isDefault: jsonSerialization['isDefault'] as bool,
      version: jsonSerialization['version'] as int,
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

  int companyId;

  String name;

  String content;

  bool isDefault;

  int version;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ReportTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReportTemplate copyWith({
    int? id,
    int? companyId,
    String? name,
    String? content,
    bool? isDefault,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReportTemplate',
      if (id != null) 'id': id,
      'companyId': companyId,
      'name': name,
      'content': content,
      'isDefault': isDefault,
      'version': version,
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

class _ReportTemplateImpl extends ReportTemplate {
  _ReportTemplateImpl({
    int? id,
    required int companyId,
    required String name,
    required String content,
    required bool isDefault,
    required int version,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         name: name,
         content: content,
         isDefault: isDefault,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ReportTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReportTemplate copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? name,
    String? content,
    bool? isDefault,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReportTemplate(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      content: content ?? this.content,
      isDefault: isDefault ?? this.isDefault,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
