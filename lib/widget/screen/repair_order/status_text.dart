import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/widget/common/animated_text_switcher/index.dart';

class UploadStatusText extends StatelessWidget {
  final RepairOrderUploadVideoRequestModel? request;
  final OfflineEnqueueItemModel? offlineItem;
  final OfflineEnqueueItemRepairOrderVideoUploadModel? offlineData;

  const UploadStatusText({
    Key? key,
    required this.request,
    this.offlineItem,
    this.offlineData,
  }) : super(key: key);

  String get _title {
    if (offlineData?.status == null) return "Starting";

    if (offlineData!.status == OfflineEnqueueItemRepairOrderVideoUploadStatus.pictureUpload) {
      return "${OfflineEnqueueItemRepairOrderVideoUploadStatus.pictureUpload.name} Nº ${int.parse(offlineData!.statusData) + 1}";
    }

    return offlineData!.status!.name;
  }

  bool get _progressVisible => offlineData != null && offlineData!.progressVisible;

  String get _label {
    String progress = _progressVisible ? " ${(offlineData?.progress ?? 0.0).toStringAsFixed(2)}%" : "";
    return "$_title$progress";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomAnimatedTextSwitcher(
          text: _label,
          alignment: Alignment.centerRight,
          textStyle: Theme.of(context).textTheme.caption,
        ),
        Container(
          height: 10,
          width: 10,
          margin: const EdgeInsets.only(left: 8.0),
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
      ],
    );
  }
}
