// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageListItemModel _$$_MessageListItemModelFromJson(
        Map<String, dynamic> json) =>
    _$_MessageListItemModel(
      offlineEnqueueUid: json['offlineEnqueueUid'] as String? ?? "",
      offlineEnqueueStatus: $enumDecodeNullable(
              _$OfflineEnqueueItemStatusEnumMap,
              json['offlineEnqueueStatus']) ??
          OfflineEnqueueItemStatus.pending,
      isFromOfflineEnqueue: json['isFromOfflineEnqueue'] as bool? ?? false,
      model: json['model'] == null
          ? null
          : MessageModel.fromJson(json['model'] as Map<String, dynamic>),
      type: $enumDecodeNullable(_$MessageListItemTypeEnumMap, json['type']) ??
          MessageListItemType.first,
      title: json['title'] as String? ?? "",
    );

Map<String, dynamic> _$$_MessageListItemModelToJson(
        _$_MessageListItemModel instance) =>
    <String, dynamic>{
      'offlineEnqueueUid': instance.offlineEnqueueUid,
      'offlineEnqueueStatus':
          _$OfflineEnqueueItemStatusEnumMap[instance.offlineEnqueueStatus],
      'isFromOfflineEnqueue': instance.isFromOfflineEnqueue,
      'model': instance.model?.toJson(),
      'type': _$MessageListItemTypeEnumMap[instance.type],
      'title': instance.title,
    };

const _$OfflineEnqueueItemStatusEnumMap = {
  OfflineEnqueueItemStatus.pending: 'pending',
  OfflineEnqueueItemStatus.processing: 'processing',
  OfflineEnqueueItemStatus.done: 'done',
  OfflineEnqueueItemStatus.error: 'error',
};

const _$MessageListItemTypeEnumMap = {
  MessageListItemType.first: 'first',
  MessageListItemType.middle: 'middle',
  MessageListItemType.last: 'last',
  MessageListItemType.single: 'single',
};
