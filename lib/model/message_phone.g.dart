// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_phone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessagePhoneModel _$$_MessagePhoneModelFromJson(Map<String, dynamic> json) =>
    _$_MessagePhoneModel(
      countryCode: json['countryCode'] as String? ?? "",
      isoCode: json['isoCode'] as String? ?? "",
      e164: json['e164'] as String? ?? "",
      number: json['number'] as String? ?? "",
    );

Map<String, dynamic> _$$_MessagePhoneModelToJson(
        _$_MessagePhoneModel instance) =>
    <String, dynamic>{
      'countryCode': instance.countryCode,
      'isoCode': instance.isoCode,
      'e164': instance.e164,
      'number': instance.number,
    };
