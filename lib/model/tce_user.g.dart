// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tce_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TCEUserModel _$$_TCEUserModelFromJson(Map<String, dynamic> json) =>
    _$_TCEUserModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? "",
      firstName: json['firstName'] as String? ?? "",
      middleName: json['middleName'] as String? ?? "",
      lastName: json['lastName'] as String? ?? "",
      emailAddress: json['emailAddress'] as String? ?? "",
      mobileNumber: json['mobileNumber'] as String? ?? "",
      dealer: json['dealer'] == null
          ? null
          : DealerModel.fromJson(json['dealer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TCEUserModelToJson(_$_TCEUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'mobileNumber': instance.mobileNumber,
      'dealer': instance.dealer?.toJson(),
    };
