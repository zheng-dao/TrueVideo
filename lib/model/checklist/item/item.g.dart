// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      uid: json['uid'] as String? ?? "",
      defaultValue: json['defaultValue'] ?? "",
      inputType: json['inputType'] as String? ?? "",
      validations: (json['validations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      skippable: json['skippable'] as bool? ?? true,
      required: json['required'] as bool? ?? false,
      enabled: json['enabled'] as bool? ?? true,
      extraNotes: (json['extraNotes'] as List<dynamic>?)
              ?.map((e) => ExtraNote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ExtraNote>[],
      availableOptions: (json['availableOptions'] as List<dynamic>?)
              ?.map((e) => AvailableOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AvailableOption>[],
      config: (json['config'] as List<dynamic>?)
              ?.map((e) => ItemConfigItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ItemConfigItem>[],
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'uid': instance.uid,
      'defaultValue': instance.defaultValue,
      'inputType': instance.inputType,
      'validations': instance.validations,
      'skippable': instance.skippable,
      'required': instance.required,
      'enabled': instance.enabled,
      'extraNotes': instance.extraNotes.map((e) => e.toJson()).toList(),
      'availableOptions':
          instance.availableOptions.map((e) => e.toJson()).toList(),
      'config': instance.config.map((e) => e.toJson()).toList(),
    };
