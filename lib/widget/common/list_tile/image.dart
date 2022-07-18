import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/image/model/placeholder.dart';

class CustomListTileImage extends StatelessWidget {
  final CustomImageDataSource? source;
  final IconData? icon;
  final Color? color;
  final Color? iconColor;
  final double width;
  final double height;

  final bool circle;

  const CustomListTileImage({
    Key? key,
    this.source,
    this.icon,
    this.color,
    this.iconColor,
    this.width = 40.0,
    this.height = 40.0,
    this.circle = true,
  }) : super(key: key);

  const CustomListTileImage.small({
    Key? key,
    this.source,
    this.icon,
    this.color,
    this.iconColor,
    this.width = 30.0,
    this.height = 30.0,
    this.circle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomImage(
      width: width,
      height: height,
      source: source ?? CustomImageDataSource.network("", color: Colors.transparent),
      placeholder: CustomImagePlaceholder(
        icon: icon,
        iconColor: iconColor,
        color: color,
        iconSize: 18,
      ),
      circle: circle,
    );
  }
}
