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

abstract class Report implements _i1.SerializableModel {
  Report._({
    this.id,
    required this.companyId,
    required this.startDate,
    required this.endDate,
    required this.content,
    this.rawCommitsJson,
    this.aiSummary,
    this.notes,
    required this.status,
    this.sentAt,
    this.deliveryChannel,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Report({
    int? id,
    required int companyId,
    required DateTime startDate,
    required DateTime endDate,
    required String content,
    String? rawCommitsJson,
    String? aiSummary,
    String? notes,
    required String status,
    DateTime? sentAt,
    String? deliveryChannel,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ReportImpl;

  factory Report.fromJson(Map<String, dynamic> jsonSerialization) {
    return Report(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      content: jsonSerialization['content'] as String,
      rawCommitsJson: jsonSerialization['rawCommitsJson'] as String?,
      aiSummary: jsonSerialization['aiSummary'] as String?,
      notes: jsonSerialization['notes'] as String?,
      status: jsonSerialization['status'] as String,
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      deliveryChannel: jsonSerialization['deliveryChannel'] as String?,
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

  DateTime startDate;

  DateTime endDate;

  String content;

  String? rawCommitsJson;

  String? aiSummary;

  String? notes;

  String status;

  DateTime? sentAt;

  String? deliveryChannel;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Report copyWith({
    int? id,
    int? companyId,
    DateTime? startDate,
    DateTime? endDate,
    String? content,
    String? rawCommitsJson,
    String? aiSummary,
    String? notes,
    String? status,
    DateTime? sentAt,
    String? deliveryChannel,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Report',
      if (id != null) 'id': id,
      'companyId': companyId,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'content': content,
      if (rawCommitsJson != null) 'rawCommitsJson': rawCommitsJson,
      if (aiSummary != null) 'aiSummary': aiSummary,
      if (notes != null) 'notes': notes,
      'status': status,
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      if (deliveryChannel != null) 'deliveryChannel': deliveryChannel,
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

class _ReportImpl extends Report {
  _ReportImpl({
    int? id,
    required int companyId,
    required DateTime startDate,
    required DateTime endDate,
    required String content,
    String? rawCommitsJson,
    String? aiSummary,
    String? notes,
    required String status,
    DateTime? sentAt,
    String? deliveryChannel,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         startDate: startDate,
         endDate: endDate,
         content: content,
         rawCommitsJson: rawCommitsJson,
         aiSummary: aiSummary,
         notes: notes,
         status: status,
         sentAt: sentAt,
         deliveryChannel: deliveryChannel,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Report copyWith({
    Object? id = _Undefined,
    int? companyId,
    DateTime? startDate,
    DateTime? endDate,
    String? content,
    Object? rawCommitsJson = _Undefined,
    Object? aiSummary = _Undefined,
    Object? notes = _Undefined,
    String? status,
    Object? sentAt = _Undefined,
    Object? deliveryChannel = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Report(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      content: content ?? this.content,
      rawCommitsJson: rawCommitsJson is String?
          ? rawCommitsJson
          : this.rawCommitsJson,
      aiSummary: aiSummary is String? ? aiSummary : this.aiSummary,
      notes: notes is String? ? notes : this.notes,
      status: status ?? this.status,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      deliveryChannel: deliveryChannel is String?
          ? deliveryChannel
          : this.deliveryChannel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
