// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageMemberModel _$$_MessageMemberModelFromJson(
        Map<String, dynamic> json) =>
    _$_MessageMemberModel(
      uid: json['uid'] as String? ?? "",
      displayName: json['displayName'] as String? ?? "",
      phone: json['phone'] == null
          ? null
          : MessagePhoneModel.fromJson(json['phone'] as Map<String, dynamic>),
      channelUid: json['channelUid'] as String? ?? "",
      unreadMessages: json['unreadMessages'] as int? ?? 0,
      pinned: json['pinned'] as bool? ?? false,
      enabled: json['enabled'] as bool? ?? false,
      visible: json['visible'] as bool? ?? false,
      lastMessage: json['lastMessage'] == null
          ? null
          : MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MessageMemberModelToJson(
        _$_MessageMemberModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'phone': instance.phone?.toJson(),
      'channelUid': instance.channelUid,
      'unreadMessages': instance.unreadMessages,
      'pinned': instance.pinned,
      'enabled': instance.enabled,
      'visible': instance.visible,
      'lastMessage': instance.lastMessage?.toJson(),
    };
