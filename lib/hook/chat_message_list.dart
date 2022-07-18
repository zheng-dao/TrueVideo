import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/model/message.dart';
import 'package:truvideo_enterprise/model/message_channel.dart';
import 'package:truvideo_enterprise/model/message_user.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_chat.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_type.dart';
import 'package:truvideo_enterprise/riverpod/messaging_authentication_information.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/widget/screen/message_list/model/message_list_item_model.dart';
import 'package:truvideo_enterprise/widget/screen/message_list/model/messagee_list_item_type.dart';

bool _isChatByAccount({
  MessageChannelModel? channel,
  required String subjectUID,
}) {
  if (channel == null || subjectUID.trim().isEmpty) return false;
  final members = channel.members;
  return !members.any((e) => e.uid == subjectUID);
}

List<MessageListItemModel> useChatMessageList(
  WidgetRef ref, {
  required String channelUID,
  List<MessageModel> messages = const <MessageModel>[],
  MessageChannelModel? channel,
}) {
  final OfflineEnqueueService offlineEnqueueService = GetIt.I.get();
  final DateService dateService = GetIt.I.get();
  final streamEnqueue = useStream(useMemoized(() => offlineEnqueueService.stream(type: [OfflineEnqueueItemType.chat])));
  final subjectUID = ref.watch(messagingAuthenticationInformationPod)?.subjectMessageableEntity?.uid;
  final subAccountUID = ref.watch(messagingAuthenticationInformationPod)?.subAccountMessageableEntity?.uid;

  return useMemoized(
    () {
      final isChatByAccount = _isChatByAccount(
        subjectUID: subjectUID ?? "",
        channel: channel,
      );

      final pendingItems = (streamEnqueue.data ?? [])
          .map((e) {
            try {
              final data = OfflineEnqueueItemChatModel.fromJson(e.data ?? <String, dynamic>{});

              // Filter by memberUID
              if (data.channelUID != channelUID) return null;

              // If the online items contains the pending item, not show this pending item
              if (messages.any((e) => e.auxUID == data.auxUID)) return null;

              MessageModel message;

              // if has result, means that the enqueue has finished and 'result' contains the new inserted message
              if (e.result != null) {
                final createdMessage = MessageModel.fromJson(e.result!);

                // If the message is already in the online list, not show this pending item
                if (messages.any((i) => i.uid == createdMessage.uid)) return null;
                message = createdMessage;
              } else {
                message = MessageModel(
                  uid: "enqueue_${e.uid}",
                  auxUID: data.auxUID,
                  body: data.text,
                  createdAt: e.createdAt,
                  channelUID: channelUID,
                  createdBy: MessageUserModel(
                    uid: isChatByAccount ? (subAccountUID ?? "") : (subjectUID ?? ""),
                  ),
                );
              }

              return MessageListItemModel(
                isFromOfflineEnqueue: true,
                offlineEnqueueStatus: e.status,
                offlineEnqueueUid: e.uid,
                model: message,
              );
            } catch (error) {
              return null;
            }
          })
          .where((element) => element != null)
          .map((e) => e!)
          .toList();

      var result = [
        ...pendingItems,
        ...messages
            .map((e) => MessageListItemModel(
                  isFromOfflineEnqueue: false,
                  model: e,
                  offlineEnqueueStatus: OfflineEnqueueItemStatus.done,
                ))
            .toList(),
      ];

      result.sort((a, b) {
        final d1 = a.model?.createdAt ?? DateTime.now();
        final d2 = b.model?.createdAt ?? DateTime.now();
        return d2.compareTo(d1);
      });

      var r = <MessageListItemModel>[];

      for (int i = 0; i < result.length; i++) {
        MessageListItemModel? previous;
        if (i > 0) {
          previous = result[i - 1];
        }
        final current = result[i];
        MessageListItemModel? next;
        if (i < (result.length - 1)) {
          next = result[i + 1];
        }

        MessageListItemType type;
        String prevUID = "";
        String currentUID = ""; //1
        String nextUID = ""; // 2

        if (previous != null) {
          prevUID = previous.model?.createdBy?.uid ?? "";
        }
        currentUID = current.model?.createdBy?.uid ?? "";
        if (next != null) {
          nextUID = next.model?.createdBy?.uid ?? "";
        }

        if (prevUID != currentUID) {
          if (nextUID != currentUID) {
            type = MessageListItemType.single;
          } else {
            type = MessageListItemType.first;
          }
        } else {
          if (nextUID != currentUID) {
            type = MessageListItemType.last;
          } else {
            type = MessageListItemType.middle;
          }
        }

        result[i] = current.copyWith(type: type);
      }

      final groupedByDate =
          groupBy<MessageListItemModel, String>(result, (obj) => (obj.model?.createdAt ?? DateTime.now()).toString().substring(0, 10));
      r = <MessageListItemModel>[];
      groupedByDate.forEach((key, value) {
        if (value.isNotEmpty) {
          final last = value.removeLast();

          r.addAll(value);

          String title = "";
          final date = DateTime.parse(key);
          if (DateUtils.isSameDay(date, DateTime.now())) {
            title = "Today";
          } else {
            if (DateUtils.isSameDay(date, DateTime.now().subtract(const Duration(hours: 24)))) {
              title = "Yesterday";
            } else {
              title = dateService.formatDate(date);
            }
          }

          r.add(last.copyWith(title: title));
        }
      });
      result = r;

      return result;
    },
    [messages, streamEnqueue.data, channel, subjectUID, subAccountUID],
  );
}
