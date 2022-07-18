import 'dart:math';

import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';

class CustomCameraPanelOptions extends StatelessWidget {
  final bool visible;
  final Widget child;
  final Function()? close;

  const CustomCameraPanelOptions({
    Key? key,
    this.visible = true,
    required this.child,
    this.close,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedFadeVisibility(
      visible: visible,
      child: GestureDetector(
        onTap: close,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: CustomColorsUtils.cameraPanelBackground,
            child: Transform.rotate(
              angle: pi / 2,
              child: Container(
                color: Colors.transparent,
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
