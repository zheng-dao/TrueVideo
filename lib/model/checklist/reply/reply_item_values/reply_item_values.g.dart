// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_item_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReplyItemValues _$$_ReplyItemValuesFromJson(Map<String, dynamic> json) =>
    _$_ReplyItemValues(
      optionGroupUID: json['optionGroupUID'] as String,
      optionUID: json['optionUID'] as String? ?? "",
      value: json['value'] as String?,
    );

Map<String, dynamic> _$$_ReplyItemValuesToJson(_$_ReplyItemValues instance) =>
    <String, dynamic>{
      'optionGroupUID': instance.optionGroupUID,
      'optionUID': instance.optionUID,
      'value': instance.value,
    };
