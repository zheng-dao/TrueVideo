// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_number.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PhoneNumberModel _$$_PhoneNumberModelFromJson(Map<String, dynamic> json) =>
    _$_PhoneNumberModel(
      country: json['country'] == null
          ? const PhoneNumberCountryModel()
          : PhoneNumberCountryModel.fromJson(
              json['country'] as Map<String, dynamic>),
      e164: json['e164'] as String? ?? "",
      formattedNationalNumber: json['formattedNationalNumber'] as String? ?? "",
      formattedInternationalNumber:
          json['formattedInternationalNumber'] as String? ?? "",
      number: json['number'] as String? ?? "",
      mobileNumber: json['mobileNumber'] as bool? ?? false,
    );

Map<String, dynamic> _$$_PhoneNumberModelToJson(_$_PhoneNumberModel instance) =>
    <String, dynamic>{
      'country': instance.country.toJson(),
      'e164': instance.e164,
      'formattedNationalNumber': instance.formattedNationalNumber,
      'formattedInternationalNumber': instance.formattedInternationalNumber,
      'number': instance.number,
      'mobileNumber': instance.mobileNumber,
    };
