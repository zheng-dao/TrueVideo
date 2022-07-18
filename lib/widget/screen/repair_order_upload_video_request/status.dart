import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';

class ScreenRepairOrderUploadVideoRequestStatus extends StatelessWidget {
  final RepairOrderUploadVideoRequestModel request;
  final OfflineEnqueueItemModel? offlineItem;
  final OfflineEnqueueItemRepairOrderVideoUploadModel? offlineData;

  final EdgeInsets? margin;

  const ScreenRepairOrderUploadVideoRequestStatus({
    Key? key,
    required this.request,
    this.offlineItem,
    this.margin,
    this.offlineData,
  }) : super(key: key);

  String get _title {
    if (offlineData?.status == null) return "";

    if (offlineData!.status == OfflineEnqueueItemRepairOrderVideoUploadStatus.pictureUpload) {
      return "${OfflineEnqueueItemRepairOrderVideoUploadStatus.pictureUpload.name} Nº ${int.parse(offlineData!.statusData) + 1}";
    }

    return offlineData!.status!.name;
  }

  @override
  Widget build(BuildContext context) {
    final visible = request.offlineEnqueueStatus == OfflineEnqueueItemStatus.processing;

    return CustomAnimatedCollapseVisibility(
      visible: visible,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.all(32.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Uploading video",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            CustomAnimatedCollapseVisibility(
              visible: _title.trim().isNotEmpty,
              child: Text(_title),
            ),
            CustomAnimatedCollapseVisibility(
              visible: offlineData != null && offlineData!.progressVisible,
              child: Text(
                "${(offlineData?.progress ?? 0.0).toStringAsFixed(2)}%",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
