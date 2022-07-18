import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';

import 'button.dart';
import 'button_capture.dart';
import 'button_rotate.dart';
import 'dart:math' as math;

class CustomCameraButtons extends HookConsumerWidget {
  final Function()? onChangeCameraPressed;
  final bool enabled;
  final Function()? onCapturePressed;
  final bool video;
  final bool recordingVideo;
  final bool recordingVideoPaused;
  final Function()? onQualityPressed;
  final Function()? onVideoPausePressed;
  final Function()? onVideoTakePicturePressed;
  final Function()? onPicturesCountPressed;
  final int picturesCount;
  final bool picturesCountVisible;
  final bool visible;

  const CustomCameraButtons({
    Key? key,
    this.onQualityPressed,
    this.onChangeCameraPressed,
    this.onVideoPausePressed,
    this.enabled = true,
    this.onCapturePressed,
    this.recordingVideoPaused = false,
    required this.video,
    required this.recordingVideo,
    this.onVideoTakePicturePressed,
    this.onPicturesCountPressed,
    this.picturesCount = 0,
    this.picturesCountVisible = true,
    this.visible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final takePictureVisible = video;
    const size = 60.0;
    const spacing = 8.0;

    return CustomAnimatedFadeVisibility(
      visible: visible,
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + (Platform.isAndroid ? 16.0 : 0.0),
          top: 16,
        ),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pause
                  CustomAnimatedFadeVisibility(
                    visible: video && recordingVideo,
                    child: Transform.rotate(
                      angle: pi / 2,
                      child: CustomCameraButton(
                        enabled: enabled,
                        size: size,
                        icon: recordingVideoPaused ? Icons.play_arrow : Icons.pause,
                        onPressed: onVideoPausePressed,
                      ),
                    ),
                  ),

                  const SizedBox(width: 4.0),

                  // Take picture
                  CustomAnimatedFadeVisibility(
                    visible: takePictureVisible,
                    child: Transform.rotate(
                      angle: pi / 2,
                      child: CustomCameraButton(
                        size: size,
                        icon: Icons.camera_alt_outlined,
                        enabled: enabled,
                        onPressed: onVideoTakePicturePressed,
                      ),
                    ),
                  ),

                  const SizedBox(width: spacing),

                  // Capture
                  CustomCameraButtonCapture(
                    enabled: enabled,
                    video: video,
                    recordingVideo: recordingVideo,
                    onPressed: onCapturePressed,
                  ),
                  const SizedBox(width: spacing),

                  // Change camera
                  Transform.rotate(
                    angle: pi / 2,
                    child: CustomCameraButtonRotate(
                      size: size,
                      enabled: enabled,
                      onPressed: onChangeCameraPressed,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  const CustomAnimatedFadeVisibility(
                    visible: false,
                    child: CustomCameraButton(
                      size: size,
                      icon: Icons.help,
                    ),
                  ),
                ],
              ),
            ),
            CustomAnimatedFadeVisibility(
              visible: picturesCountVisible && picturesCount > 0,
              child: IgnorePointer(
                ignoring: true,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Colors.transparent,
                  child: Transform.rotate(
                    angle: math.pi / 2,
                    child: CustomBorderButton.small(
                      text: picturesCount.toString(),
                      textColor: Colors.white,
                      icon: Icons.image_outlined,
                      borderColor: Colors.transparent,
                      fillColor: Colors.transparent,
                      iconOnLeft: false,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
