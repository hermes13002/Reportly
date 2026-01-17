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
import 'company.dart' as _i2;
import 'delivery_channel.dart' as _i3;
import 'greetings/greeting.dart' as _i4;
import 'report.dart' as _i5;
import 'report_template.dart' as _i6;
import 'repository.dart' as _i7;
import 'schedule_config.dart' as _i8;
import 'package:reportly_client/src/protocol/company.dart' as _i9;
import 'package:reportly_client/src/protocol/delivery_channel.dart' as _i10;
import 'package:reportly_client/src/protocol/report.dart' as _i11;
import 'package:reportly_client/src/protocol/report_template.dart' as _i12;
import 'package:reportly_client/src/protocol/repository.dart' as _i13;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i14;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i15;
export 'company.dart';
export 'delivery_channel.dart';
export 'greetings/greeting.dart';
export 'report.dart';
export 'report_template.dart';
export 'repository.dart';
export 'schedule_config.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Company) {
      return _i2.Company.fromJson(data) as T;
    }
    if (t == _i3.DeliveryChannel) {
      return _i3.DeliveryChannel.fromJson(data) as T;
    }
    if (t == _i4.Greeting) {
      return _i4.Greeting.fromJson(data) as T;
    }
    if (t == _i5.Report) {
      return _i5.Report.fromJson(data) as T;
    }
    if (t == _i6.ReportTemplate) {
      return _i6.ReportTemplate.fromJson(data) as T;
    }
    if (t == _i7.Repository) {
      return _i7.Repository.fromJson(data) as T;
    }
    if (t == _i8.ScheduleConfig) {
      return _i8.ScheduleConfig.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Company?>()) {
      return (data != null ? _i2.Company.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.DeliveryChannel?>()) {
      return (data != null ? _i3.DeliveryChannel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Greeting?>()) {
      return (data != null ? _i4.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Report?>()) {
      return (data != null ? _i5.Report.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ReportTemplate?>()) {
      return (data != null ? _i6.ReportTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Repository?>()) {
      return (data != null ? _i7.Repository.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ScheduleConfig?>()) {
      return (data != null ? _i8.ScheduleConfig.fromJson(data) : null) as T;
    }
    if (t == List<_i9.Company>) {
      return (data as List).map((e) => deserialize<_i9.Company>(e)).toList()
          as T;
    }
    if (t == List<_i10.DeliveryChannel>) {
      return (data as List)
              .map((e) => deserialize<_i10.DeliveryChannel>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.Report>) {
      return (data as List).map((e) => deserialize<_i11.Report>(e)).toList()
          as T;
    }
    if (t == List<_i12.ReportTemplate>) {
      return (data as List)
              .map((e) => deserialize<_i12.ReportTemplate>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.Repository>) {
      return (data as List).map((e) => deserialize<_i13.Repository>(e)).toList()
          as T;
    }
    try {
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i15.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Company => 'Company',
      _i3.DeliveryChannel => 'DeliveryChannel',
      _i4.Greeting => 'Greeting',
      _i5.Report => 'Report',
      _i6.ReportTemplate => 'ReportTemplate',
      _i7.Repository => 'Repository',
      _i8.ScheduleConfig => 'ScheduleConfig',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('reportly.', '');
    }

    switch (data) {
      case _i2.Company():
        return 'Company';
      case _i3.DeliveryChannel():
        return 'DeliveryChannel';
      case _i4.Greeting():
        return 'Greeting';
      case _i5.Report():
        return 'Report';
      case _i6.ReportTemplate():
        return 'ReportTemplate';
      case _i7.Repository():
        return 'Repository';
      case _i8.ScheduleConfig():
        return 'ScheduleConfig';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i15.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Company') {
      return deserialize<_i2.Company>(data['data']);
    }
    if (dataClassName == 'DeliveryChannel') {
      return deserialize<_i3.DeliveryChannel>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i4.Greeting>(data['data']);
    }
    if (dataClassName == 'Report') {
      return deserialize<_i5.Report>(data['data']);
    }
    if (dataClassName == 'ReportTemplate') {
      return deserialize<_i6.ReportTemplate>(data['data']);
    }
    if (dataClassName == 'Repository') {
      return deserialize<_i7.Repository>(data['data']);
    }
    if (dataClassName == 'ScheduleConfig') {
      return deserialize<_i8.ScheduleConfig>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i14.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i15.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i14.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i15.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
