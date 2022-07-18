// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_enqueue_item_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OfflineEnqueueItemChatModel _$$_OfflineEnqueueItemChatModelFromJson(
        Map<String, dynamic> json) =>
    _$_OfflineEnqueueItemChatModel(
      text: json['text'] as String? ?? "",
      accountUID: json['accountUID'] as String? ?? "",
      channelUID: json['channelUID'] as String? ?? "",
      auxUID: json['auxUID'] as String? ?? "",
    );

Map<String, dynamic> _$$_OfflineEnqueueItemChatModelToJson(
        _$_OfflineEnqueueItemChatModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'accountUID': instance.accountUID,
      'channelUID': instance.channelUID,
      'auxUID': instance.auxUID,
    };
