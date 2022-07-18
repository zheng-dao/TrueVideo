import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';

class CustomThumbnailDim extends StatelessWidget {
  final bool left;
  final double borderRadius;
  final Color? color;
  final bool enabled;

  const CustomThumbnailDim({
    Key? key,
    this.left = true,
    this.borderRadius = 0.0,
    this.color,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedFadeVisibility(
      visible: enabled,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(left ? borderRadius : 0.0),
            bottomLeft: Radius.circular(left ? borderRadius : 0.0),
            topRight: Radius.circular(!left ? borderRadius : 0.0),
            bottomRight: Radius.circular(!left ? borderRadius : 0.0),
          ),
          color: color ?? Colors.black.withOpacity(0.6),
        ),
      ),
    );
  }
}
