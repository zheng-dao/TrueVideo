// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageChannelModel _$$_MessageChannelModelFromJson(
        Map<String, dynamic> json) =>
    _$_MessageChannelModel(
      members: (json['members'] as List<dynamic>?)
              ?.map(
                  (e) => MessageMemberModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MessageMemberModel>[],
      uid: json['uid'] as String? ?? "",
      displayName: json['displayName'] as String? ?? "",
      entityType: json['entityType'] as String? ?? "",
      type: json['type'] as String? ?? "",
      accountUID: json['accountUID'] as String? ?? "",
      createdAt: DateTimeConverter.fromJson(json['createdAt']),
      updatedAt: DateTimeConverter.fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$_MessageChannelModelToJson(
        _$_MessageChannelModel instance) =>
    <String, dynamic>{
      'members': instance.members.map((e) => e.toJson()).toList(),
      'uid': instance.uid,
      'displayName': instance.displayName,
      'entityType': instance.entityType,
      'type': instance.type,
      'accountUID': instance.accountUID,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
