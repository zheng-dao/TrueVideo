// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserSettingsModel _$$_UserSettingsModelFromJson(Map<String, dynamic> json) =>
    _$_UserSettingsModel(
      key: json['key'] as String? ?? "",
      value: json['value'] as String?,
      displayName: json['displayName'] as String?,
      type: json['type'] as String? ?? "",
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => UserSettingsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UserSettingsModelToJson(
        _$_UserSettingsModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'displayName': instance.displayName,
      'type': instance.type,
      'children': instance.children?.map((e) => e.toJson()).toList(),
    };
