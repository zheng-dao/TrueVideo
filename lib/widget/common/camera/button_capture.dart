import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_scale_visibility/index.dart';

class CustomCameraButtonCapture extends StatelessWidget {
  final bool video;
  final bool recordingVideo;
  final Function()? onPressed;
  final bool enabled;

  const CustomCameraButtonCapture({
    Key? key,
    this.video = false,
    this.recordingVideo = false,
    this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const size = 80.0;
    return CustomAnimatedFadeVisibility(
      visible: enabled,
      minOpacity: 0.5,
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: CustomColorsUtils.cameraButtonFillColor,
          border: Border.all(
            color: CustomColorsUtils.cameraCaptureButtonBorderColor,
            width: 3,
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: ScaleTap(
            onPressed: onPressed,
            child: CustomAnimatedScale(
              scale: video && recordingVideo ? 0.7 : 1.0,
              child: AnimatedContainer(
                width: size,
                height: size,
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: video ? CustomColorsUtils.cameraCaptureButtonVideoColor : CustomColorsUtils.cameraCaptureButtonPictureColor,
                  borderRadius: BorderRadius.circular(video && recordingVideo ? 10 : size * 0.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
