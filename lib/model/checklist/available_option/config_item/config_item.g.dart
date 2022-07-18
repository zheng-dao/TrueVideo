// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConfigItem _$$_ConfigItemFromJson(Map<String, dynamic> json) =>
    _$_ConfigItem(
      name: json['name'] as String? ?? "",
      type: json['type'] as String? ?? "",
      colorName: json['colorName'] as String? ?? "",
      description: json['description'] as String? ?? "",
      displayName: json['displayName'] as String? ?? "",
      classObject: json['class'],
    );

Map<String, dynamic> _$$_ConfigItemToJson(_$_ConfigItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'colorName': instance.colorName,
      'description': instance.description,
      'displayName': instance.displayName,
      'class': instance.classObject,
    };
