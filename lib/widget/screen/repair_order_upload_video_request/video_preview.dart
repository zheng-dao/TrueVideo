import 'dart:io';

import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/video_player/model/data.dart';
import 'package:truvideo_enterprise/widget/common/video_viewer/index.dart';

class ScreenRepairOrderVideoUploadRequestVideoPreview extends HookConsumerWidget {
  final EdgeInsets? margin;
  final RepairOrderUploadVideoRequestModel request;
  final OfflineEnqueueItemModel? offlineItem;
  final OfflineEnqueueItemRepairOrderVideoUploadModel? offlineData;

  const ScreenRepairOrderVideoUploadRequestVideoPreview({
    Key? key,
    required this.request,
    this.margin,
    this.offlineItem,
    this.offlineData,
  }) : super(key: key);

  bool get _exists {
    final source = _videoSource;
    if (!source.isFile) return true;
    return File(source.data).existsSync();
  }

  _onButtonPlayPressed() {
    if (!_exists) {
      showCustomDialogRetry(
        title: "Error",
        message: "Video file not found",
        cancelButtonVisible: false,
        retryButtonText: "Accept",
      );
      return;
    }

    showCustomVideoViewer(
      _videoSource,
      thumbnail: _thumbnail,
      thumbnailHeroTag: "video",
    );
  }

  CustomVideoPlayerDataSource get _videoSource {
    final videoRequest = request.cameraResult?.video;

    CustomVideoPlayerDataSource source;
    if ((offlineData?.videoURL ?? "").trim().isNotEmpty) {
      source = CustomVideoPlayerDataSource.network(offlineData!.videoURL);
    } else {
      source = CustomVideoPlayerDataSource.file(videoRequest?.info.path ?? "");
    }

    return source;
  }

  CustomImageDataSource get _thumbnail {
    final videoRequest = request.cameraResult?.video;

    CustomImageDataSource thumbnailSource;
    if (offlineData == null) {
      thumbnailSource = CustomImageDataSource.file(videoRequest?.thumbnailPath ?? "");
    } else {
      if (offlineData!.videoThumbnailURL.trim().isNotEmpty) {
        thumbnailSource = CustomImageDataSource.network(offlineData!.videoThumbnailURL);
      } else {
        thumbnailSource = CustomImageDataSource.file(videoRequest?.thumbnailPath ?? "");
      }
    }

    return thumbnailSource;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateService dateService = GetIt.I.get();
    final videoRequest = request.cameraResult?.video;
    double videoAspectRatio = 1.0;
    if (videoRequest != null) {
      final w = request.cameraResult?.video.info.width ?? 0;
      final h = request.cameraResult?.video.info.height ?? 0;
      videoAspectRatio = h / w;

      if (videoRequest.info.rotation == 0 || videoRequest.info.rotation == 180) {
        videoAspectRatio = 1 / videoAspectRatio;
      }
    }

    final videoDuration = useMemoized(
      () => dateService.duration(
        Duration(milliseconds: request.cameraResult?.video.info.durationMillis ?? 0),
        forceHour: false,
      ),
      [request.cameraResult?.video.info.durationMillis],
    );

    final videoSize = useMemoized(
      () => filesize(request.cameraResult?.video.info.size ?? 0),
      [request.cameraResult?.video.info.size],
    );

    return Container(
      width: double.infinity,
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text("Video", style: Theme.of(context).textTheme.titleSmall),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: videoAspectRatio,
                  child: CustomImage(
                    heroTag: "video",
                    borderRadius: BorderRadius.circular(4.0),
                    source: _thumbnail,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              CustomButtonIcon(
                size: 60,
                icon: Icons.play_arrow_outlined,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                iconColor: Colors.white,
                elevation: 8,
                onPressed: _onButtonPlayPressed,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Size: $videoSize",
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            "Duration: $videoDuration",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
