import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';

class CustomCameraButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;
  final bool enabled;
  final EdgeInsets? margin;
  final Color? borderColor;
  final double? borderWidth;
  final double? size;
  final Color? iconColor;

  const CustomCameraButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.enabled = true,
    this.margin,
    this.borderColor,
    this.borderWidth,
    this.size,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButtonIcon(
      margin: margin,
      enabled: enabled,
      size: size,
      borderColor: borderColor ?? CustomColorsUtils.cameraButtonBorderColor,
      backgroundColor: CustomColorsUtils.cameraButtonFillColor,
      icon: icon,
      iconColor: iconColor ?? CustomColorsUtils.cameraButtonFillColor.contrast(context),
      onPressed: onPressed,
      borderWidth: borderWidth ?? 1,
      elevation: 0,
      focusedElevation: 0,
    );
  }
}
