// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      publicUserUuid: json['publicUserUuid'] as String? ?? "",
      firstName: json['firstName'] as String? ?? "",
      lastName: json['lastName'] as String? ?? "",
      title: json['title'] as String? ?? "",
      emailAddress: json['emailAddress'] as String? ?? "",
      role: json['role'] as String? ?? "",
      dealer: json['dealer'] == null
          ? null
          : UserDealerModel.fromJson(json['dealer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'publicUserUuid': instance.publicUserUuid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'title': instance.title,
      'emailAddress': instance.emailAddress,
      'role': instance.role,
      'dealer': instance.dealer?.toJson(),
    };
