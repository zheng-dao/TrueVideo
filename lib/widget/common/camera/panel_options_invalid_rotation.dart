import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_auto_rotation/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_rotation/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'dart:math' as math;

import 'package:truvideo_enterprise/widget/mixin/accelerometer.dart';

class CustomCameraPanelOptionsInvalidRotation extends HookConsumerWidget {
  final bool visible;
  final AccelerometerRotationPosition currentRotation;
  final Function()? onButtonClosePressed;
  final Function()? onButtonGalleryPressed;

  const CustomCameraPanelOptionsInvalidRotation({
    Key? key,
    this.visible = true,
    required this.currentRotation,
    this.onButtonClosePressed,
    this.onButtonGalleryPressed,
  }) : super(key: key);

  double get _rotation {
    switch (currentRotation) {
      case AccelerometerRotationPosition.portrait:
        return 0.0;
      case AccelerometerRotationPosition.landscape:
        return math.pi / 2;
      case AccelerometerRotationPosition.landscapeInverse:
        return -math.pi / 2;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomAnimatedFadeVisibility(
      visible: visible,
      child: CustomScaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appbar: CustomAppBar(
          backgroundColor: Colors.transparent,
          actionButtons: [
            CustomButtonIcon(
              margin: const EdgeInsets.only(right: 5.0),
              backgroundColor: Colors.transparent,
              icon: Icons.clear,
              iconColor: Colors.white,
              onPressed: onButtonClosePressed,
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: CustomColorsUtils.cameraPanelBackground,
          child: Container(
            color: Colors.transparent,
            child: CustomAnimatedRotation(
              rotation: _rotation,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomAnimatedAutoRotation(
                      child: Transform.rotate(
                        angle: math.pi / 4,
                        child: const Icon(
                          Icons.screen_rotation_outlined,
                          color: Colors.white,
                          size: 56,
                        ),
                      ),
                    ),
                    Text(
                      "Rotate your device",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                    ),
                    Text(
                      "The device must be on landscape mode",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    CustomBorderButton(
                      onPressed: onButtonGalleryPressed,
                      margin: const EdgeInsets.only(top: 32.0),
                      icon: MdiIcons.imageMultipleOutline,
                      text: "Choose from gallery",
                      textColor: Colors.white,
                      fillColor: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
