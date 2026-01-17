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

abstract class DeliveryChannel implements _i1.SerializableModel {
  DeliveryChannel._({
    this.id,
    required this.companyId,
    required this.channelType,
    required this.name,
    required this.configJson,
    required this.isActive,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeliveryChannel({
    int? id,
    required int companyId,
    required String channelType,
    required String name,
    required String configJson,
    required bool isActive,
    required bool isDefault,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DeliveryChannelImpl;

  factory DeliveryChannel.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeliveryChannel(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      channelType: jsonSerialization['channelType'] as String,
      name: jsonSerialization['name'] as String,
      configJson: jsonSerialization['configJson'] as String,
      isActive: jsonSerialization['isActive'] as bool,
      isDefault: jsonSerialization['isDefault'] as bool,
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

  String channelType;

  String name;

  String configJson;

  bool isActive;

  bool isDefault;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DeliveryChannel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeliveryChannel copyWith({
    int? id,
    int? companyId,
    String? channelType,
    String? name,
    String? configJson,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeliveryChannel',
      if (id != null) 'id': id,
      'companyId': companyId,
      'channelType': channelType,
      'name': name,
      'configJson': configJson,
      'isActive': isActive,
      'isDefault': isDefault,
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

class _DeliveryChannelImpl extends DeliveryChannel {
  _DeliveryChannelImpl({
    int? id,
    required int companyId,
    required String channelType,
    required String name,
    required String configJson,
    required bool isActive,
    required bool isDefault,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         channelType: channelType,
         name: name,
         configJson: configJson,
         isActive: isActive,
         isDefault: isDefault,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DeliveryChannel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeliveryChannel copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? channelType,
    String? name,
    String? configJson,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DeliveryChannel(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      channelType: channelType ?? this.channelType,
      name: name ?? this.name,
      configJson: configJson ?? this.configJson,
      isActive: isActive ?? this.isActive,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
