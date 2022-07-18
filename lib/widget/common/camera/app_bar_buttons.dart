import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:truvideo_enterprise/hook/camera_quality.dart';
import 'package:truvideo_enterprise/service/settings/camera_quality.dart';
import 'dart:math' as math;

import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/camera/button.dart';
import 'package:truvideo_enterprise/widget/common/camera/util/flash_mode_extension.dart';
import 'package:truvideo_enterprise/widget/mixin/accelerometer.dart';

class CustomCameraAppBarButtons extends HookConsumerWidget {
  final bool visible;
  final bool enabled;
  final AccelerometerRotationPosition currentRotation;
  final List<FlashMode> flashModes;
  final FlashMode currentFlashMode;
  final bool narratorMode;
  final Function()? onButtonClosePressed;
  final Function()? onButtonCameraQualityPressed;
  final Function()? onButtonFlashModePressed;
  final Function()? onButtonInvalidRotationPressed;
  final Function()? onButtonNarratorModePressed;
  final bool video;
  final bool recordingVideo;
  final bool recordingVideoPaused;

  const CustomCameraAppBarButtons({
    Key? key,
    this.visible = true,
    required this.currentRotation,
    this.enabled = true,
    required this.flashModes,
    required this.currentFlashMode,
    this.narratorMode = true,
    this.onButtonNarratorModePressed,
    this.onButtonClosePressed,
    this.onButtonCameraQualityPressed,
    this.onButtonFlashModePressed,
    this.onButtonInvalidRotationPressed,
    required this.video,
    required this.recordingVideo,
    required this.recordingVideoPaused,
  }) : super(key: key);

  bool get _withFlashModes {
    return flashModes.where((e) => e != FlashMode.off).isNotEmpty;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraQuality = useCameraQuality(ref);
    const size = 50.0;
    const spacing = 8.0;

    bool buttonCameraQualityEnabled = false;
    if (enabled) {
      if (recordingVideo) {
        buttonCameraQualityEnabled = false;
      } else {
        buttonCameraQualityEnabled = true;
      }
    } else {
      buttonCameraQualityEnabled = false;
    }

    bool narratorModeEnabled = false;
    if (enabled) {
      if (recordingVideo) {
        if (recordingVideoPaused) {
          narratorModeEnabled = true;
        } else {
          narratorModeEnabled = false;
        }
      } else {
        narratorModeEnabled = true;
      }
    }

    return CustomAnimatedFadeVisibility(
      visible: visible,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          spacing: spacing,
          runSpacing: spacing,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.end,
          children: [
            // Flash
            Container(
              key: const ValueKey("button-flash-mode"),
              child: Transform.rotate(
                angle: math.pi / 2,
                child: CustomCameraButton(
                  size: size,
                  icon: currentFlashMode.icon,
                  enabled: enabled && _withFlashModes,
                  onPressed: onButtonFlashModePressed,
                ),
              ),
            ),

            // Narrator mode
            Container(
              key: const ValueKey("button-narrator-mode"),
              child: Transform.rotate(
                angle: math.pi / 2,
                child: CustomCameraButton(
                  size: size,
                  enabled: narratorModeEnabled,
                  icon: narratorMode ? MdiIcons.microphone : MdiIcons.microphoneOff,
                  onPressed: onButtonNarratorModePressed,
                ),
              ),
            ),

            // Camera quality
            Container(
              key: const ValueKey("button-quality"),
              child: Transform.rotate(
                angle: math.pi / 2,
                child: CustomCameraButton(
                  size: size,
                  enabled: buttonCameraQualityEnabled,
                  icon: cameraQuality.icon,
                  onPressed: onButtonCameraQualityPressed,
                ),
              ),
            ),

            // Close
            CustomCameraButton(
              size: size,
              key: const ValueKey("button-close"),
              icon: Icons.clear,
              onPressed: onButtonClosePressed,
            ),
          ],
        ),
      ),
    );
  }
}
