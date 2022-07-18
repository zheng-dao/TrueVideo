import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/camera/camera_picture_file.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';

class ScreenRepairOrderDetailVideoGalleryItemPicture extends StatelessWidget {
  final RepairOrderUploadVideoRequestModel model;
  final CameraPictureFileModel picture;
  final OfflineEnqueueItemRepairOrderVideoUploadModel? offlineData;
  final double previewSize;

  const ScreenRepairOrderDetailVideoGalleryItemPicture({
    Key? key,
    this.offlineData,
    required this.picture,
    required this.model,
    this.previewSize = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var source = CustomImageDataSource.file(picture.path, fit: BoxFit.cover);
    if (offlineData != null) {
      final url = offlineData!.picturesURL[picture.path] ?? "";
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
