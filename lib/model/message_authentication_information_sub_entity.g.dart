// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_authentication_information_sub_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageAuthenticationInformationSubEntityModel
    _$$_MessageAuthenticationInformationSubEntityModelFromJson(
            Map<String, dynamic> json) =>
        _$_MessageAuthenticationInformationSubEntityModel(
          businessReference: json['businessReference'] == null
              ? null
              : MessageEntityReferenceModel.fromJson(
                  json['businessReference'] as Map<String, dynamic>),
          subAccountUID: json['subAccountUID'] as String? ?? "",
          accountUID: json['accountUID'] as String? ?? "",
          uid: json['uid'] as String? ?? "",
          displayName: json['displayName'] as String? ?? "",
          createdAt: DateTimeConverter.fromJson(json['createdAt']),
          updatedAt: DateTimeConverter.fromJson(json['updatedAt']),
        );

Map<String, dynamic> _$$_MessageAuthenticationInformationSubEntityModelToJson(
        _$_MessageAuthenticationInformationSubEntityModel instance) =>
    <String, dynamic>{
      'businessReference': instance.businessReference?.toJson(),
      'subAccountUID': instance.subAccountUID,
      'accountUID': instance.accountUID,
      'uid': instance.uid,
      'displayName': instance.displayName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
