// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SectionConfig _$$_SectionConfigFromJson(Map<String, dynamic> json) =>
    _$_SectionConfig(
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
      customName: json['customName'] as String? ?? "",
      type: json['type'] as String? ?? "",
      inputOrder: json['inputOrder'] as int?,
      outputOrder: json['outputOrder'] as int?,
      isPrintable: json['isPrintable'] as bool? ?? true,
      visibleFor: json['visibleFor'] ?? "",
    );

Map<String, dynamic> _$$_SectionConfigToJson(_$_SectionConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'customName': instance.customName,
      'type': instance.type,
      'inputOrder': instance.inputOrder,
      'outputOrder': instance.outputOrder,
      'isPrintable': instance.isPrintable,
      'visibleFor': instance.visibleFor,
    };
