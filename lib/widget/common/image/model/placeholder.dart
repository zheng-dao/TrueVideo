import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CustomImagePlaceholder extends Equatable {
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final Color? color;

  const CustomImagePlaceholder({
    this.icon,
    this.iconColor,
    this.iconSize,
    this.color,
  });

  @override
  List<Object?> get props => [icon, iconColor, iconSize, color];
}
