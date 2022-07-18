// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DeviceInfoModel _$$_DeviceInfoModelFromJson(Map<String, dynamic> json) =>
    _$_DeviceInfoModel(
      id: json['id'] as String? ?? "",
      manufacturer: json['manufacturer'] as String? ?? "",
      model: json['model'] as String? ?? "",
      name: json['name'] as String? ?? "",
      phoneOS: json['phoneOS'] as String? ?? "",
    );

Map<String, dynamic> _$$_DeviceInfoModelToJson(_$_DeviceInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'name': instance.name,
      'phoneOS': instance.phoneOS,
    };
