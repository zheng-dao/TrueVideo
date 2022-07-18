import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/image/model/placeholder.dart';

import 'model/data.dart';
import 'model/data_source_type.dart';

class CustomImage extends StatelessWidget {
  final CustomImageDataSource? source;
  final CustomImagePlaceholder? placeholder;
  final bool circle;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final Function()? retry;
  final String? heroTag;
  final Duration duration;

  const CustomImage({
    Key? key,
    this.circle = false,
    this.source,
    this.height,
    this.width,
    this.borderRadius,
    this.retry,
    this.heroTag,
    this.placeholder,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  Widget _buildPlaceholder(BuildContext context) {
    final p = placeholder;
    final icon = p?.icon;
    final iconSize = p?.iconSize ?? 18;
    final color = p?.color ?? Theme.of(context).dividerColor;
    final iconColor = p?.iconColor ?? color.contrast(context);

    if (icon == null) {
      return AnimatedContainer(
        key: const ValueKey("empty"),
        duration: duration,
        width: width,
        height: height,
        color: color,
      );
    }

    return AnimatedContainer(
      key: const ValueKey("placeholder"),
      duration: duration,
      width: width,
      height: height,
      alignment: Alignment.center,
      color: color,
      child: AnimatedSwitcher(
        duration: duration,
        child: Icon(
          icon,
          key: ValueKey("${icon}_$iconColor"),
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    final p = placeholder;
    final iconSize = p?.iconSize ?? 18;
    final color = p?.color ?? Theme.of(context).dividerColor;
    final iconColor = p?.iconColor ?? color.contrast(context);

    return GestureDetector(
      key: const ValueKey("error"),
      onTap: () {
        retry?.call();
      },
      child: AnimatedContainer(
        duration: duration,
        width: width,
        height: height,
        color: color,
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: duration,
          child: Icon(
            MdiIcons.exclamationThick,
            key: ValueKey("$iconColor"),
            size: iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  Widget _heroWrapper({required Widget child}) {
    final tag = heroTag;
    if (tag == null) return child;

    return Hero(
      tag: tag,
      child: child,
    );
  }

  Widget _buildChild(BuildContext context) {
    final s = source;
    final fit = s?.fit ?? BoxFit.contain;
    final color = s?.color ?? Theme.of(context).dividerColor;

    Widget imageChild;

    final withData = s != null && (s.data.trim().isNotEmpty || s.bytes != null || s.imageProvider != null);

    if (!withData) {
      imageChild = _buildPlaceholder(context);
    } else {
      ImageProvider imageProvider;
      switch (s.type) {
        case CustomImageDataSourceType.file:
          imageProvider = FileImage(File(s.data));
          break;
        case CustomImageDataSourceType.network:
          imageProvider = NetworkImage(s.data);
          break;
        case CustomImageDataSourceType.memory:
          imageProvider = MemoryImage(s.bytes ?? kTransparentImage);
          break;
        case CustomImageDataSourceType.asset:
          imageProvider = AssetImage(s.data);
          break;
        case CustomImageDataSourceType.provider:
          imageProvider = s.imageProvider ?? MemoryImage(kTransparentImage);
          break;
      }

      imageChild = ExtendedImage(
        key: const ValueKey("image file"),
        image: imageProvider,
        fit: fit,
        width: width,
        height: height,
        loadStateChanged: (state) {
          Widget child;
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              child = _buildPlaceholder(context);
              break;
            case LoadState.completed:
              child = state.completedWidget;
              break;
            case LoadState.failed:
              child = _buildError(context);
              break;
          }
          return _heroWrapper(
            child: AnimatedSwitcher(
              duration: duration,
              child: Container(
                key: ValueKey(state.extendedImageLoadState),
                child: child,
              ),
            ),
          );
        },
      );
    }

    return AnimatedContainer(
      duration: duration,
      width: width,
      height: height,
      color: color,
      child: imageChild,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      child: Container(
        key: ValueKey(circle),
        decoration: BoxDecoration(
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
        ),
        clipBehavior: Clip.hardEdge,
        child: AnimatedContainer(
          duration: duration,
          decoration: BoxDecoration(
            borderRadius: circle ? null : borderRadius ?? BorderRadius.zero,
          ),
          clipBehavior: Clip.hardEdge,
          child: _buildChild(context),
        ),
      ),
    );
  }
}
