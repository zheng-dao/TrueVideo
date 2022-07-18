// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_number_country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PhoneNumberCountryModel _$$_PhoneNumberCountryModelFromJson(
        Map<String, dynamic> json) =>
    _$_PhoneNumberCountryModel(
      isoCode: json['isoCode'] as String? ?? "",
      countryCode: json['countryCode'] as String? ?? "",
      internationalMobileMask: json['internationalMobileMask'] as String? ?? "",
      nationalMobileMask: json['nationalMobileMask'] as String? ?? "",
      internationalInlineMask: json['internationalInlineMask'] as String? ?? "",
      nationalInlineMask: json['nationalInlineMask'] as String? ?? "",
      name: json['name'] as String? ?? "",
    );

Map<String, dynamic> _$$_PhoneNumberCountryModelToJson(
        _$_PhoneNumberCountryModel instance) =>
    <String, dynamic>{
      'isoCode': instance.isoCode,
      'countryCode': instance.countryCode,
      'internationalMobileMask': instance.internationalMobileMask,
      'nationalMobileMask': instance.nationalMobileMask,
      'internationalInlineMask': instance.internationalInlineMask,
      'nationalInlineMask': instance.nationalInlineMask,
      'name': instance.name,
    };
