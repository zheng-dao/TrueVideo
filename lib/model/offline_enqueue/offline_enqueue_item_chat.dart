// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'offline_enqueue_item_chat.freezed.dart';

part 'offline_enqueue_item_chat.g.dart';

@freezed
class OfflineEnqueueItemChatModel with _$OfflineEnqueueItemChatModel {
  const OfflineEnqueueItemChatModel._();

  @JsonSerializable(explicitToJson: true)
  const factory OfflineEnqueueItemChatModel({
    @Default("") String text,
    @Default("") String accountUID,
    @Default("") String channelUID,
    @Default("") String auxUID,
  }) = _OfflineEnqueueItemChatModel;

  factory OfflineEnqueueItemChatModel.fromJson(Map<String, dynamic> json) => _$OfflineEnqueueItemChatModelFromJson(json);
}
