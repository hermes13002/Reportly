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

abstract class ScheduleConfig implements _i1.SerializableModel {
  ScheduleConfig._({
    this.id,
    required this.companyId,
    required this.frequency,
    this.customDays,
    this.dayOfWeek,
    this.dayOfMonth,
    required this.hourOfDay,
    required this.minuteOfHour,
    required this.isEnabled,
    this.lastRunAt,
    this.nextRunAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduleConfig({
    int? id,
    required int companyId,
    required String frequency,
    int? customDays,
    int? dayOfWeek,
    int? dayOfMonth,
    required int hourOfDay,
    required int minuteOfHour,
    required bool isEnabled,
    DateTime? lastRunAt,
    DateTime? nextRunAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ScheduleConfigImpl;

  factory ScheduleConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScheduleConfig(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      frequency: jsonSerialization['frequency'] as String,
      customDays: jsonSerialization['customDays'] as int?,
      dayOfWeek: jsonSerialization['dayOfWeek'] as int?,
      dayOfMonth: jsonSerialization['dayOfMonth'] as int?,
      hourOfDay: jsonSerialization['hourOfDay'] as int,
      minuteOfHour: jsonSerialization['minuteOfHour'] as int,
      isEnabled: jsonSerialization['isEnabled'] as bool,
      lastRunAt: jsonSerialization['lastRunAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastRunAt']),
      nextRunAt: jsonSerialization['nextRunAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['nextRunAt']),
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

  String frequency;

  int? customDays;

  int? dayOfWeek;

  int? dayOfMonth;

  int hourOfDay;

  int minuteOfHour;

  bool isEnabled;

  DateTime? lastRunAt;

  DateTime? nextRunAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ScheduleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduleConfig copyWith({
    int? id,
    int? companyId,
    String? frequency,
    int? customDays,
    int? dayOfWeek,
    int? dayOfMonth,
    int? hourOfDay,
    int? minuteOfHour,
    bool? isEnabled,
    DateTime? lastRunAt,
    DateTime? nextRunAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScheduleConfig',
      if (id != null) 'id': id,
      'companyId': companyId,
      'frequency': frequency,
      if (customDays != null) 'customDays': customDays,
      if (dayOfWeek != null) 'dayOfWeek': dayOfWeek,
      if (dayOfMonth != null) 'dayOfMonth': dayOfMonth,
      'hourOfDay': hourOfDay,
      'minuteOfHour': minuteOfHour,
      'isEnabled': isEnabled,
      if (lastRunAt != null) 'lastRunAt': lastRunAt?.toJson(),
      if (nextRunAt != null) 'nextRunAt': nextRunAt?.toJson(),
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

class _ScheduleConfigImpl extends ScheduleConfig {
  _ScheduleConfigImpl({
    int? id,
    required int companyId,
    required String frequency,
    int? customDays,
    int? dayOfWeek,
    int? dayOfMonth,
    required int hourOfDay,
    required int minuteOfHour,
    required bool isEnabled,
    DateTime? lastRunAt,
    DateTime? nextRunAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         frequency: frequency,
         customDays: customDays,
         dayOfWeek: dayOfWeek,
         dayOfMonth: dayOfMonth,
         hourOfDay: hourOfDay,
         minuteOfHour: minuteOfHour,
         isEnabled: isEnabled,
         lastRunAt: lastRunAt,
         nextRunAt: nextRunAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ScheduleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduleConfig copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? frequency,
    Object? customDays = _Undefined,
    Object? dayOfWeek = _Undefined,
    Object? dayOfMonth = _Undefined,
    int? hourOfDay,
    int? minuteOfHour,
    bool? isEnabled,
    Object? lastRunAt = _Undefined,
    Object? nextRunAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScheduleConfig(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      frequency: frequency ?? this.frequency,
      customDays: customDays is int? ? customDays : this.customDays,
      dayOfWeek: dayOfWeek is int? ? dayOfWeek : this.dayOfWeek,
      dayOfMonth: dayOfMonth is int? ? dayOfMonth : this.dayOfMonth,
      hourOfDay: hourOfDay ?? this.hourOfDay,
      minuteOfHour: minuteOfHour ?? this.minuteOfHour,
      isEnabled: isEnabled ?? this.isEnabled,
      lastRunAt: lastRunAt is DateTime? ? lastRunAt : this.lastRunAt,
      nextRunAt: nextRunAt is DateTime? ? nextRunAt : this.nextRunAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
