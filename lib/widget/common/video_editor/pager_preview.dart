
import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/video_editor/processing_picture.dart';
import 'package:truvideo_enterprise/model/video_editor/processing_video.dart';
import 'package:truvideo_enterprise/widget/common/video_editor/pager_preview_image.dart';

import 'pager_preview_video.dart';

class CustomCameraVideoResultPagerPreview extends StatelessWidget {
  final VideoEditorProcessingVideoModel? video;
  final List<VideoEditorProcessingPictureModel> pictures;
  final int currentPage;
  final Function(VideoEditorProcessingPictureModel model)? onPicturePressed;
  final Function()? onVideoPressed;

  const CustomCameraVideoResultPagerPreview({
    Key? key,
    this.currentPage = 0,
    this.video,
    this.pictures = const [],
    this.onPicturePressed,
    this.onVideoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Videos
        CustomCameraVideoResultPagerPreviewVideo(
          onPressed: onVideoPressed,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          video: video,
          selected: currentPage == 0,
        ),

        // Pictures
        for (int i = 0; i < pictures.length; i++)
          CustomCameraVideoResultPagerPreviewPicture(
            onPressed: onPicturePressed,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            model: pictures[i],
            selected: currentPage == (i + 1),
          )
      ],
    );
  }
}
