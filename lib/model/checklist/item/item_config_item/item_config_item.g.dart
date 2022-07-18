// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_config_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ItemConfigItem _$$_ItemConfigItemFromJson(Map<String, dynamic> json) =>
    _$_ItemConfigItem(
      inputDescription: json['inputDescription'] as String? ?? "",
      inputName: json['inputName'] as String? ?? "",
      outputDescription: json['outputDescription'] as String? ?? "",
      outputName: json['outputName'] as String? ?? "",
      type: json['type'] as String? ?? "",
      unit: json['unit'] as String? ?? "",
      precision: json['precision'] as String? ?? "",
      inputType: json['inputType'] as String? ?? "",
      inputOrder: json['inputOrder'] as int?,
      outputOrder: json['outputOrder'] as int?,
      classObject: json['classObject'],
      isPrintable: json['isPrintable'] as bool? ?? false,
      visibleFor: json['visibleFor'] as String? ?? "",
    );

Map<String, dynamic> _$$_ItemConfigItemToJson(_$_ItemConfigItem instance) =>
    <String, dynamic>{
      'inputDescription': instance.inputDescription,
      'inputName': instance.inputName,
      'outputDescription': instance.outputDescription,
      'outputName': instance.outputName,
      'type': instance.type,
      'unit': instance.unit,
      'precision': instance.precision,
      'inputType': instance.inputType,
      'inputOrder': instance.inputOrder,
      'outputOrder': instance.outputOrder,
      'classObject': instance.classObject,
      'isPrintable': instance.isPrintable,
      'visibleFor': instance.visibleFor,
    };
