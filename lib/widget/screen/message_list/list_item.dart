import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/model/message_channel.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/riverpod/messaging_authentication_information.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/placeholder.dart';
import 'package:truvideo_enterprise/widget/screen/message_list/date_separator.dart';
import 'package:truvideo_enterprise/widget/screen/message_list/model/messagee_list_item_type.dart';

import 'model/message_list_item_model.dart';

class MessageListItem extends HookConsumerWidget {
  final MessageListItemModel model;
  final Function(MessageListItemModel model)? onPressed;
  final Function(MessageListItemModel model)? onLongPressed;
  final bool selected;
  final MessageChannelModel? channel;

  const MessageListItem({
    Key? key,
    required this.model,
    this.onPressed,
    this.onLongPressed,
    this.selected = false,
    this.channel,
  }) : super(key: key);

  Widget _buildDate(
    BuildContext context, {
    required DateService dateService,
    required bool isMe,
    required Color color,
  }) {
    if (model.isFromOfflineEnqueue && model.offlineEnqueueStatus != OfflineEnqueueItemStatus.done) {
      switch (model.offlineEnqueueStatus) {
        case OfflineEnqueueItemStatus.pending:
        case OfflineEnqueueItemStatus.processing:
          return AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: Theme.of(context).textTheme.caption?.copyWith(color: color.contrast(context).withOpacity(0.6)) ?? const TextStyle(),
            child: Text(
              "Pending",
              textAlign: isMe ? TextAlign.right : TextAlign.left,
            ),
          );
        case OfflineEnqueueItemStatus.done:
          return Container();
        case OfflineEnqueueItemStatus.error:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 12,
                color: Colors.red.shade600,
              ),
              const SizedBox(width: 4.0),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.red.shade600) ?? const TextStyle(),
                child: Text(
                  "Error",
                  textAlign: isMe ? TextAlign.right : TextAlign.left,
                ),
              ),
            ],
          );
      }
    }

    if (model.model?.createdAt == null) return Container();
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: Theme.of(context).textTheme.caption?.copyWith(color: color.contrast(context).withOpacity(0.6)) ?? const TextStyle(),
      child: Text(
        dateService.timeAgo(model.model!.createdAt!),
        textAlign: isMe ? TextAlign.right : TextAlign.left,
      ),
    );
  }

  EdgeInsets _margin(bool isMe) {
    switch (model.type) {
      case MessageListItemType.last:
        return EdgeInsets.only(top: 16.0, bottom: 2.0, left: isMe ? 54 : 16.0, right: 16.0);
      case MessageListItemType.middle:
        return EdgeInsets.only(top: 2.0, bottom: 2.0, left: isMe ? 54 : 16.0, right: 16.0);
      case MessageListItemType.first:
        return EdgeInsets.only(top: 2.0, bottom: 2.0, left: isMe ? 54 : 16.0, right: 16.0);
      case MessageListItemType.single:
        return EdgeInsets.only(top: 16.0, bottom: 2.0, left: isMe ? 54 : 16.0, right: 16.0);
    }
  }

  bool get _isNameVisible => [MessageListItemType.last, MessageListItemType.single].contains(model.type);

  bool get _isImageVisible => [MessageListItemType.first, MessageListItemType.single].contains(model.type);

  BorderRadius _borderRadius(bool isMe) {
    switch (model.type) {
      case MessageListItemType.last:
        return BorderRadius.only(
          topLeft: const Radius.circular(10.0),
          topRight: const Radius.circular(10.0),
          bottomLeft: Radius.circular(isMe ? 10.0 : 0.0),
          bottomRight: Radius.circular(!isMe ? 10.0 : 0.0),
        );
      case MessageListItemType.middle:
        return BorderRadius.only(
          topLeft: Radius.circular(isMe ? 10.0 : 0.0),
          bottomLeft: Radius.circular(isMe ? 10.0 : 0.0),
          topRight: Radius.circular(!isMe ? 10.0 : 0.0),
          bottomRight: Radius.circular(!isMe ? 10.0 : 0.0),
        );
      case MessageListItemType.first:
        return BorderRadius.only(
          bottomLeft: const Radius.circular(10.0),
          bottomRight: const Radius.circular(10.0),
          topRight: Radius.circular(isMe ? 0.0 : 10.0),
          topLeft: Radius.circular(!isMe ? 0.0 : 10.0),
        );
      case MessageListItemType.single:
        return const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        );
    }
  }

  String _userName(String uid) {
    if (channel == null) return "";
    final member = channel?.members.firstWhereOrNull((e) => e.uid == uid);
    if (member == null) return "Unknown name";
    return member.displayName;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateService dateService = GetIt.I.get();
    final subjectMessageableUid = ref.watch(messagingAuthenticationInformationPod)?.subjectMessageableEntity?.uid;
    final subAccountMessageableUid = ref.watch(messagingAuthenticationInformationPod)?.subAccountMessageableEntity?.uid;
    final isMe = [subjectMessageableUid, subAccountMessageableUid].contains(model.model?.createdBy?.uid ?? "");
    var color = isMe ? CustomColorsUtils.messageBubbleMe : CustomColorsUtils.messageBubbleOther;
    if (selected) {
      color = CustomColorsUtils.accent;
    }

    final createdByDisplayName = useMemoized(
      () {
        return _userName(model.model?.createdBy?.uid ?? "");
      },
      [model.model?.createdBy?.uid, channel],
    );

    return Column(
      children: [
        if (model.title.trim().isNotEmpty) ScreenMessageListTitle(text: model.title),
        GestureDetector(
          onTap: () {
            onPressed?.call(model);
            CustomKeyboardUtils.hide();
          },
          onLongPress: onLongPressed == null ? null : () => onLongPressed!(model),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(selected ? 0.1 : 0.0),
            ),
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: _margin(isMe),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isMe)
                    Opacity(
                      opacity: _isImageVisible ? 1.0 : 0.0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        child: CustomImage(
                          placeholder: CustomImagePlaceholder(
                            color: Colors.transparent,
                            icon: Icons.person_outline,
                            iconSize: 12,
                            iconColor: color.contrast(context),
                          ),
                        ),
                      ),
                    ),
                  Flexible(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: _borderRadius(isMe),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: RawMaterialButton(
                        fillColor: Colors.transparent,
                        elevation: 0,
                        hoverElevation: 0,
                        highlightElevation: 0,
                        focusElevation: 0,
                        disabledElevation: 0,
                        onPressed: onPressed == null ? null : () => onPressed!(model),
                        onLongPress: onLongPressed == null ? null : () => onLongPressed!(model),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          constraints: const BoxConstraints(minWidth: 180),
                          child: Column(
                            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              if (_isNameVisible && createdByDisplayName.trim().isNotEmpty)
                                AnimatedDefaultTextStyle(
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: color.contrast(context),
                                            fontWeight: FontWeight.bold,
                                          ) ??
                                      const TextStyle(),
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(
                                    createdByDisplayName,
                                    textAlign: isMe ? TextAlign.right : TextAlign.left,
                                  ),
                                ),
                              if (_isNameVisible && createdByDisplayName.trim().isNotEmpty) const SizedBox(height: 8.0),
                              AnimatedDefaultTextStyle(
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color.contrast(context)) ?? const TextStyle(),
                                duration: const Duration(milliseconds: 300),
                                child: Text(
                                  model.model!.body.trim(),
                                  textAlign: isMe ? TextAlign.right : TextAlign.left,
                                ),
                              ),
                              _buildDate(
                                context,
                                color: color,
                                dateService: dateService,
                                isMe: isMe,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
