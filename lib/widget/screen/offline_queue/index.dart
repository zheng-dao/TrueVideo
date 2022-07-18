import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/chip/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/json_viewer/index.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/core/colors.dart';

class ScreenOfflineQueue extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenOfflineQueue";

  const ScreenOfflineQueue({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenOfflineQueue> createState() => _ScreenOfflineQueueState();
}

class _ScreenOfflineQueueState extends ConsumerState<ScreenOfflineQueue> {
  _close() {
    Navigator.of(context).pop();
  }

  _onItemPressed(OfflineEnqueueItemModel model) {
    showCustomDialog(
      title: "Offline enqueue item",
      childPadding: EdgeInsets.zero,
      builder: (context, controller) => CustomJsonViewer(json: model.toJson()),
      buttonsBuilder: (context, controller) => [
        CustomBorderButton.small(
          text: "Delete",
          icon: Icons.delete_outline,
          textColor: CustomColorsUtils.delete,
          onPressed: () async {
            controller.setLoading(true);

            try {
              final OfflineEnqueueService service = GetIt.I.get();
              await service.delete(model.uid);
            } catch (error, stack) {
              log("Error deleting", error: error, stackTrace: stack);
            }

            controller.close();
          },
        ),
        CustomBorderButton.small(
          text: "Accept",
          onPressed: () {
            controller.close();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBarIconColor = Theme.of(context).appBarTheme.backgroundColor?.contrast(context);

    final OfflineEnqueueService service = GetIt.I.get();
    final DateService dateService = GetIt.I.get();
    final stream = useStream(useMemoized(() => service.stream()));
    final data = stream.data ?? [];

    return CustomScaffold(
      appbar: CustomAppBar(
        title: "Offline queue",
        leading: CustomButtonIcon(
          icon: Icons.arrow_back_ios,
          backgroundColor: Colors.transparent,
          iconColor: appBarIconColor,
          onPressed: _close,
        ),
      ),
      body: CustomFadingEdgeList(
        child: CustomList<OfflineEnqueueItemModel>.separated(
          padding: EdgeInsets.only(top: 16, bottom: 16 + MediaQuery.of(context).padding.bottom),
          loading: stream.connectionState == ConnectionState.waiting,
          areItemsTheSame: (a, b) => a.uid == b.uid,
          data: data,
          itemBuilder: (context, item) => CustomListTile(
            onPressed: () => _onItemPressed(item),
            titleText: item.type.name,
            trailing: CustomChip(
              text: item.status.name,
              color: item.status.color,
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (item.updatedAt != null)
                  Text(
                    dateService.formatDateTime(item.updatedAt!),
                    style: Theme.of(context).textTheme.caption,
                  ),
                if (item.updatedAt == null && item.createdAt != null)
                  Text(
                    dateService.formatDateTime(item.updatedAt!),
                    style: Theme.of(context).textTheme.caption,
                  ),
              ],
            ),
          ),
          separatorBuilder: (context) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Divider(height: 1),
          ),
        ),
      ),
    );
  }
}
