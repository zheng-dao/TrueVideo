import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order_upload_video_request/index.dart';

import 'item.dart';

class ScreenRepairOrderDetailVideoGallery extends HookConsumerWidget {
  final RepairOrderDetailModel model;

  const ScreenRepairOrderDetailVideoGallery({
    Key? key,
    required this.model,
  }) : super(key: key);

  _onItemPressed(BuildContext context, RepairOrderUploadVideoRequestModel model) {
    Navigator.of(context).pushNamed(
      ScreenRepairOrderVideoUploadRequest.routeName,
      arguments: ScreenRepairOrderVideoUploadRequestParams(
        videoRequestUID: model.uid,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RepairOrderService repairOrderService = GetIt.I.get();
    final snapshot = useStream(
      useMemoized(
        () => repairOrderService.streamVideoUploadRequests(orderID: model.id),
        [model.id],
      ),
    );

    final uploads = (snapshot.data ?? <RepairOrderUploadVideoRequestModel>[]);
    final pending = useMemoized(
      () {
        final items = uploads.where((e) => e.offlineEnqueueStatus != OfflineEnqueueItemStatus.done).toList();
        items.sort((a, b) {
          final a1 = a.creationDate ?? DateTime.now();
          final a2 = b.creationDate ?? DateTime.now();
          return a2.compareTo(a1);
        });
        return items;
      },
      [uploads],
    );

    final done = useMemoized(
      () {
        final items = uploads.where((e) => e.offlineEnqueueStatus == OfflineEnqueueItemStatus.done).toList();
        items.sort((a, b) {
          final a1 = a.creationDate ?? DateTime.now();
          final a2 = b.creationDate ?? DateTime.now();
          return a2.compareTo(a1);
        });
        return items;
      },
      [uploads],
    );

    return Column(
      children: [
        // Pending
        CustomAnimatedCollapseVisibility(
          visible: pending.isNotEmpty,
          child: Container(
            margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
                  child: Text(
                    "Pending videos",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                for (int i = 0; i < pending.length; i++)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (i != 0) const CustomDivider(),
                      ScreenRepairOrderDetailVideoGalleryItem(
                        model: pending[i],
                        onPressed: (model) => _onItemPressed(context, model),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),

        // Ready
        CustomAnimatedCollapseVisibility(
          visible: done.isNotEmpty,
          child: Container(
            margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
                  child: Text(
                    "Uploaded videos",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                for (int i = 0; i < done.length; i++)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (i != 0) const CustomDivider(),
                      ScreenRepairOrderDetailVideoGalleryItem(
                        model: done[i],
                        onPressed: (model) => _onItemPressed(context, model),
                        previewSize: 80.0,
                        showStatus: false,
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
