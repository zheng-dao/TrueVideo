import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/repair_order_conversation.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/placeholder.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';

class ConversationSummary extends StatelessWidget {
  final RepairOrderConversationModel? conversation;

  const ConversationSummary({Key? key, this.conversation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateService dateService = GetIt.I.get();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Last message',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: CustomColorsUtils.accent,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () {}, //TODO
              child: Text(
                'VIEW ALL',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: CustomColorsUtils.accent,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        const CustomDivider(margin: EdgeInsets.symmetric(vertical: 16.0)),
        Row(
          children: [
            Expanded(
              child: Text(
                conversation?.lastTextMessage?.from ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: CustomColorsUtils.textLabel,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Text(
              conversation?.lastTextMessage?.dateTimeSent != null ? dateService.formatDateTime(conversation!.lastTextMessage!.dateTimeSent!) : '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CustomColorsUtils.textLabel.withOpacity(0.52),
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Text(
          conversation?.lastTextMessage?.message ?? '',
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: CustomColorsUtils.textDescription,
              ),
        ),
        const CustomDivider(margin: EdgeInsets.only(top: 16.0, bottom: 12.0)),
        GestureDetector(
          onTap: () {}, //TODO
          child: Row(
            children: [
              CustomImage(
                circle: true,
                placeholder: CustomImagePlaceholder(
                  icon: Icons.person_outline,
                  iconColor: Colors.white,
                  color: Colors.black.withOpacity(0.2),
                  iconSize: 24.0,
                ),
              ),
              const SizedBox(width: 16.0),
              Text(
                'Tap here to add a message...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: CustomColorsUtils.textLabel.withOpacity(0.52),
                    ),
              ),
            ],
          ),
        ),
        const CustomDivider(margin: EdgeInsets.only(top: 12.0, bottom: 16.0)),
      ],
    );
  }
}
