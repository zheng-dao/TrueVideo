// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_note_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExtraNoteConfig _$$_ExtraNoteConfigFromJson(Map<String, dynamic> json) =>
    _$_ExtraNoteConfig(
      displayName: json['displayName'] as String? ?? "",
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
      type: json['type'] as String? ?? "",
      classObject: json['class'],
    );

Map<String, dynamic> _$$_ExtraNoteConfigToJson(_$_ExtraNoteConfig instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'class': instance.classObject,
    };
