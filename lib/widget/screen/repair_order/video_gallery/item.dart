import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/hook/video_tags.dart';
import 'package:truvideo_enterprise/hook/video_types.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order/video_upload_request_status_button.dart';

import 'picture.dart';
import 'video.dart';

class ScreenRepairOrderDetailVideoGalleryItem extends HookConsumerWidget {
  final RepairOrderUploadVideoRequestModel model;
  final Function(RepairOrderUploadVideoRequestModel model)? onPressed;
  final bool showStatus;
  final double previewSize;

  const ScreenRepairOrderDetailVideoGalleryItem({
    Key? key,
    required this.model,
    this.onPressed,
    this.showStatus = true,
    this.previewSize = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OfflineEnqueueService offlineEnqueueService = GetIt.I.get();
    final DateService dateService = GetIt.I.get();

    final tags = useVideoTags(ref);
    final tag = useMemoized(
      () => tags.firstWhereOrNull((e) => e.key == model.videoTagID),
      [tags, model],
    );

    final types = useVideoTypes(ref);
    final type = useMemoized(
      () => types.firstWhereOrNull((e) => e.id == model.videoTypeID),
      [types, model],
    );

    final snapshotOfflineEnqueue = useStream(
      useMemoized(
        () => offlineEnqueueService.streamByUID(model.offlineEnqueueUID),
        [model.offlineEnqueueUID],
      ),
    );

    final offlineItem = snapshotOfflineEnqueue.data;
    final offlineData = useMemoized(
      () {
        if (offlineItem == null || offlineItem.data == null) return null;
        try {
          return OfflineEnqueueItemRepairOrderVideoUploadModel.fromJson(offlineItem.data!);
        } catch (error) {
          log("Error parsing OfflineEnqueueItemRepairOrderVideoUploadModel", error: error);
          return null;
        }
      },
      [offlineItem],
    );

    return InkWell(
      onTap: onPressed == null ? null : () => onPressed?.call(model),
      child: Container(
        padding: const EdgeInsets.only(top: 8.0, left: 0.0, right: 16.0, bottom: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(

                children: [
                  Expanded(
                    child: IgnorePointer(
                      ignoring: true,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children: [
                            // Video
                            ScreenRepairOrderDetailVideoGalleryItemVideo(
                              model: model,
                              offlineData: offlineData,
                              previewSize: previewSize,
                            ),

                            // Pictures
                            if (model.cameraResult?.pictures != null)
                              ...model.cameraResult!.pictures
                                  .map(
                                    (e) => ScreenRepairOrderDetailVideoGalleryItemPicture(
                                      model: model,
                                      picture: e,
                                      offlineData: offlineData,
                                      previewSize: previewSize,
                                    ),
                                  )
                                  .toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (showStatus)
                    Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      child: RepairOrderVideoUploadRequestStatus(
                        uid: model.uid,
                        showStatus: true,
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
            if (model.creationDate != null)
              Container(
                margin: const EdgeInsets.only(left: 16, top: 4.0),
                child: Text(
                  "Created at: ${dateService.formatDateTime(model.creationDate!)}",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            if (tag != null)
              Container(
                margin: const EdgeInsets.only(left: 16, top: 4.0),
                child: Text(
                  "Tag: ${tag.displayName}",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            if (type != null)
              Container(
                margin: const EdgeInsets.only(left: 16, top: 4.0),
                child: Text(
                  "Type: ${type.description}",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
