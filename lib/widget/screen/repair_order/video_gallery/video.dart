import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';

class ScreenRepairOrderDetailVideoGalleryItemVideo extends StatelessWidget {
  final RepairOrderUploadVideoRequestModel model;
  final OfflineEnqueueItemRepairOrderVideoUploadModel? offlineData;
  final double previewSize;

  const ScreenRepairOrderDetailVideoGalleryItemVideo({
    Key? key,
    this.offlineData,
    required this.model,
    this.previewSize = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var source = CustomImageDataSource.file(model.cameraResult?.video.thumbnailPath ?? "", fit: BoxFit.cover);
    if (offlineData != null) {
      final url = offlineData!.videoThumbnailURL;
      if (url.trim().isNotEmpty) {
        source = CustomImageDataSource.network(url, fit: BoxFit.cover);
      }
    }

    return SizedBox(
      width: previewSize,
      height: previewSize,
      child: CustomImage(
        source: source,
        width: previewSize,
        height: previewSize,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
