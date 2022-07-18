import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/camera/camera_picture_file.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';

class ScreenRepairOrderVideoUploadRequestPicture extends HookConsumerWidget {
  final int index;
  final CameraPictureFileModel picture;
  final OfflineEnqueueItemRepairOrderVideoUploadModel? offlineData;
  final Function(CameraPictureFileModel picture)? onPressed;

  const ScreenRepairOrderVideoUploadRequestPicture({
    Key? key,
    this.onPressed,
    required this.picture,
    this.offlineData,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String url = offlineData?.picturesURL[picture.path] ?? "";
    CustomImageDataSource source;
    if (url.trim().isEmpty) {
      source = CustomImageDataSource.file(
        picture.path,
        fit: BoxFit.cover,
      );
    } else {
      source = CustomImageDataSource.network(
        url,
        fit: BoxFit.cover,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomImage(
              heroTag: index.toString(),
              source: source,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          if (onPressed != null)
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  highlightColor: CustomColorsUtils.rippleColor,
                  focusColor: CustomColorsUtils.rippleColor,
                  hoverColor: CustomColorsUtils.rippleColor,
                  splashColor: CustomColorsUtils.rippleColor,
                  onTap: onPressed != null ? () => onPressed?.call(picture) : null,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
