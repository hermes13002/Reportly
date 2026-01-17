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

abstract class Repository implements _i1.SerializableModel {
  Repository._({
    this.id,
    required this.companyId,
    required this.provider,
    required this.repoName,
    required this.branch,
    this.prefixRules,
    this.excludePatterns,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Repository({
    int? id,
    required int companyId,
    required String provider,
    required String repoName,
    required String branch,
    String? prefixRules,
    String? excludePatterns,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RepositoryImpl;

  factory Repository.fromJson(Map<String, dynamic> jsonSerialization) {
    return Repository(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      provider: jsonSerialization['provider'] as String,
      repoName: jsonSerialization['repoName'] as String,
      branch: jsonSerialization['branch'] as String,
      prefixRules: jsonSerialization['prefixRules'] as String?,
      excludePatterns: jsonSerialization['excludePatterns'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
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

  String provider;

  String repoName;

  String branch;

  String? prefixRules;

  String? excludePatterns;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Repository]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Repository copyWith({
    int? id,
    int? companyId,
    String? provider,
    String? repoName,
    String? branch,
    String? prefixRules,
    String? excludePatterns,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Repository',
      if (id != null) 'id': id,
      'companyId': companyId,
      'provider': provider,
      'repoName': repoName,
      'branch': branch,
      if (prefixRules != null) 'prefixRules': prefixRules,
      if (excludePatterns != null) 'excludePatterns': excludePatterns,
      'isActive': isActive,
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

class _RepositoryImpl extends Repository {
  _RepositoryImpl({
    int? id,
    required int companyId,
    required String provider,
    required String repoName,
    required String branch,
    String? prefixRules,
    String? excludePatterns,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         provider: provider,
         repoName: repoName,
         branch: branch,
         prefixRules: prefixRules,
         excludePatterns: excludePatterns,
         isActive: isActive,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Repository]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Repository copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? provider,
    String? repoName,
    String? branch,
    Object? prefixRules = _Undefined,
    Object? excludePatterns = _Undefined,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Repository(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      provider: provider ?? this.provider,
      repoName: repoName ?? this.repoName,
      branch: branch ?? this.branch,
      prefixRules: prefixRules is String? ? prefixRules : this.prefixRules,
      excludePatterns: excludePatterns is String?
          ? excludePatterns
          : this.excludePatterns,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
