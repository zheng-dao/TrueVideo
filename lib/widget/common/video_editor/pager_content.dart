import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/video_editor/processing_picture.dart';
import 'package:truvideo_enterprise/model/video_editor/processing_video.dart';

import 'pager_content_image.dart';
import 'pager_content_video.dart';

class ScreenCustomCameraVideoResultPagerContent extends StatelessWidget {
  final VideoEditorProcessingVideoModel? video;
  final Function()? retryVideo;
  final List<VideoEditorProcessingPictureModel> pictures;
  final Function(VideoEditorProcessingPictureModel model)? retryPicture;
  final Function(VideoEditorProcessingPictureModel model)? onButtonRotateLeftPressed;
  final Function(VideoEditorProcessingPictureModel model)? onButtonRotateRightPressed;
  final Function(VideoEditorProcessingPictureModel model)? onButtonFlipHorizontalPressed;
  final Function(VideoEditorProcessingPictureModel model)? onButtonFlipVerticalPressed;

  final PageController? controller;
  final Function(int page)? onPageChanged;
  final Function(Duration start)? onDurationStartChange;
  final Function(Duration end)? onDurationEndChange;

  const ScreenCustomCameraVideoResultPagerContent({
    Key? key,
    this.controller,
    this.onPageChanged,
    this.onDurationStartChange,
    this.onDurationEndChange,
    required this.video,
    required this.pictures,
    this.retryPicture,
    this.retryVideo,
    this.onButtonRotateLeftPressed,
    this.onButtonRotateRightPressed,
    this.onButtonFlipHorizontalPressed,
    this.onButtonFlipVerticalPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return PageView(
          controller: controller,
          onPageChanged: onPageChanged,
          children: [
            // Videos
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: CustomCameraVideoResultPagerContentVideo(
                video: video,
                onButtonRetryPressed: retryVideo,
                onStartChange: (d) => onDurationStartChange?.call(d),
                onEndChange: (d) => onDurationEndChange?.call(d),
              ),
            ),

            // Images
            ...pictures
                .map(
                  (e) => CustomCameraVideoResultPagerContentPicture(
                    model: e,
                    onRetryPressed: retryPicture,
                    onButtonRotateLeftPressed: onButtonRotateLeftPressed,
                    onButtonRotateRightPressed: onButtonRotateRightPressed,
                    onButtonFlipHorizontalPressed: onButtonFlipHorizontalPressed,
                    onButtonFlipVerticalPressed: onButtonFlipVerticalPressed,
                  ),
                )
                .toList(),
          ],
        );
      },
    );
  }
}
