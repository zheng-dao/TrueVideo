// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageModel _$$_MessageModelFromJson(Map<String, dynamic> json) =>
    _$_MessageModel(
      uid: json['uid'] as String? ?? "",
      auxUID: json['auxUID'] as String? ?? "",
      body: json['body'] as String? ?? "",
      source: json['source'] as String? ?? "",
      type: json['type'] as String? ?? "",
      entityType: json['entityType'] as String? ?? "",
      applicationUID: json['applicationUID'] as String? ?? "",
      channelUID: json['channelUID'] as String? ?? "",
      imageURL: json['imageURL'] as String? ?? "",
      displayName: json['displayName'] as String? ?? "",
      status: json['status'] as String? ?? "",
      accountUID: json['accountUID'] as String? ?? "",
      createdBy: json['createdBy'] == null
          ? null
          : MessageUserModel.fromJson(
              json['createdBy'] as Map<String, dynamic>),
      createdAt: DateTimeConverter.fromJson(json['createdAt']),
      updatedAt: DateTimeConverter.fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$_MessageModelToJson(_$_MessageModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'auxUID': instance.auxUID,
      'body': instance.body,
      'source': instance.source,
      'type': instance.type,
      'entityType': instance.entityType,
      'applicationUID': instance.applicationUID,
      'channelUID': instance.channelUID,
      'imageURL': instance.imageURL,
      'displayName': instance.displayName,
      'status': instance.status,
      'accountUID': instance.accountUID,
      'createdBy': instance.createdBy?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
