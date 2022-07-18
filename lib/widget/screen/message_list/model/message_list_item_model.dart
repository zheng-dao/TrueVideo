// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/message.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';

import 'messagee_list_item_type.dart';

part 'message_list_item_model.freezed.dart';

part 'message_list_item_model.g.dart';

@freezed
class MessageListItemModel with _$MessageListItemModel {
  const MessageListItemModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MessageListItemModel({
    @Default("") String offlineEnqueueUid,
    @Default(OfflineEnqueueItemStatus.pending) OfflineEnqueueItemStatus offlineEnqueueStatus,
    @Default(false) bool isFromOfflineEnqueue,
    MessageModel? model,
    @Default(MessageListItemType.first) MessageListItemType type,
    @Default("") String title,
  }) = _MessageListItemModel;

  factory MessageListItemModel.fromJson(Map<String, dynamic> json) => _$MessageListItemModelFromJson(json);
}
