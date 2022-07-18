import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/model/camera/camera_picture_file.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/image_viewer/index.dart';

import 'picture_preview.dart';

class ScreenRepairOrderVideoUploadRequestPictures extends HookConsumerWidget {
  final EdgeInsets? margin;
  final RepairOrderUploadVideoRequestModel request;
  final OfflineEnqueueItemModel? offlineItem;
  final OfflineEnqueueItemRepairOrderVideoUploadModel? offlineData;

  const ScreenRepairOrderVideoUploadRequestPictures({
    Key? key,
    required this.request,
    this.margin,
    this.offlineItem,
    this.offlineData,
  }) : super(key: key);

  bool _exists(String picture) {
    final url = offlineData?.picturesURL[picture] ?? "";
    if (url.trim().isNotEmpty) {
      return true;
    }

    return File(picture).existsSync();
  }

  _onPicturePressed(CameraPictureFileModel picture) async {
    final pictures = request.cameraResult?.pictures ?? [];
    final index = pictures.indexWhere((e) => e.path == picture.path);

    if (!_exists(picture.path)) {
      showCustomDialogRetry(
        title: "Error",
        message: "Picture file not found",
        cancelButtonVisible: false,
        retryButtonText: "Accept",
      );
      return;
    }

    showCustomImageViewer(
      pictures.map((e) {
        CustomImageDataSource dataSource;
        final url = offlineData?.picturesURL[e.path];
        if ((url?.trim() ?? "").isEmpty) {
          dataSource = CustomImageDataSource.file(e.path);
        } else {
          dataSource = CustomImageDataSource.network(url ?? "");
        }

        return dataSource;
      }).toList(),
      initialIndex: index,
      heroTagBuilder: (index) => index.toString(),
      fromBoxFitCover: true,
      aspectRatioBuilder: (index) => pictures[index].height / pictures[index].width,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pictures = request.cameraResult?.pictures ?? [];

    return Container(
      width: double.infinity,
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16.0, bottom: 8.0, right: 8.0),
            child: Text("Pictures", style: Theme.of(context).textTheme.titleSmall),
          ),
          if (pictures.isEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "No pictures",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          if (pictures.isNotEmpty)
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: pictures.length,
              itemBuilder: (BuildContext context, int index) => ScreenRepairOrderVideoUploadRequestPicture(
                index: index,
                onPressed: _onPicturePressed,
                picture: pictures[index],
                offlineData: offlineData,
              ),
            ),
        ],
      ),
    );
  }
}
