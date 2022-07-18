// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_authentication_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageAuthenticationInformationModel
    _$$_MessageAuthenticationInformationModelFromJson(
            Map<String, dynamic> json) =>
        _$_MessageAuthenticationInformationModel(
          accountUID: json['accountUID'] as String? ?? "",
          subAccountUID: json['subAccountUID'] as String? ?? "",
          groups: (json['groups'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const <String>[],
          authenticated: json['authenticated'] as bool? ?? false,
          provider: json['provider'] as String? ?? "",
          subAccountMessageableEntity: json['subAccountMessageableEntity'] ==
                  null
              ? null
              : MessageAuthenticationInformationSubEntityModel.fromJson(
                  json['subAccountMessageableEntity'] as Map<String, dynamic>),
          subjectMessageableEntity: json['subjectMessageableEntity'] == null
              ? null
              : MessageAuthenticationInformationSubEntityModel.fromJson(
                  json['subjectMessageableEntity'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_MessageAuthenticationInformationModelToJson(
        _$_MessageAuthenticationInformationModel instance) =>
    <String, dynamic>{
      'accountUID': instance.accountUID,
      'subAccountUID': instance.subAccountUID,
      'groups': instance.groups,
      'authenticated': instance.authenticated,
      'provider': instance.provider,
      'subAccountMessageableEntity':
          instance.subAccountMessageableEntity?.toJson(),
      'subjectMessageableEntity': instance.subjectMessageableEntity?.toJson(),
    };
