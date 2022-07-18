// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AvailableOption _$$_AvailableOptionFromJson(Map<String, dynamic> json) =>
    _$_AvailableOption(
      uid: json['uid'] as String? ?? "",
      type: json['type'] as String? ?? "",
      enabled: json['enabled'] ?? true,
      config: (json['config'] as List<dynamic>?)
              ?.map((e) => ConfigItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ConfigItem>[],
      selectedValue: json['selectedValue'] as bool? ?? false,
      availableOptions: (json['availableOptions'] as List<dynamic>?)
              ?.map((e) => AvailableOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AvailableOption>[],
      extraNotes: (json['extraNotes'] as List<dynamic>?)
              ?.map((e) => ExtraNote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ExtraNote>[],
    );

Map<String, dynamic> _$$_AvailableOptionToJson(_$_AvailableOption instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'type': instance.type,
      'enabled': instance.enabled,
      'config': instance.config.map((e) => e.toJson()).toList(),
      'selectedValue': instance.selectedValue,
      'availableOptions':
          instance.availableOptions.map((e) => e.toJson()).toList(),
      'extraNotes': instance.extraNotes.map((e) => e.toJson()).toList(),
    };
