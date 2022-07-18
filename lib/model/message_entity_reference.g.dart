// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity_reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageEntityReferenceModel _$$_MessageEntityReferenceModelFromJson(
        Map<String, dynamic> json) =>
    _$_MessageEntityReferenceModel(
      external: json['external'] as bool? ?? false,
      entityType: json['entityType'] as String? ?? "",
      entityUID: json['entityUID'] as String? ?? "",
    );

Map<String, dynamic> _$$_MessageEntityReferenceModelToJson(
        _$_MessageEntityReferenceModel instance) =>
    <String, dynamic>{
      'external': instance.external,
      'entityType': instance.entityType,
      'entityUID': instance.entityUID,
    };
