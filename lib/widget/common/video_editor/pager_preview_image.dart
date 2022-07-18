import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/video_editor/processing_picture.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/image/model/placeholder.dart';
import 'package:truvideo_enterprise/widget/common/ripple/index.dart';


class CustomCameraVideoResultPagerPreviewPicture extends HookConsumerWidget {
  final VideoEditorProcessingPictureModel model;
  final EdgeInsets? margin;
  final Function(VideoEditorProcessingPictureModel model)? onPressed;
  final bool selected;

  const CustomCameraVideoResultPagerPreviewPicture({
    Key? key,
    required this.model,
    this.margin,
    this.onPressed,
    this.selected = false,
  }) : super(key: key);

  Widget _buildChild(BuildContext context) {
    if (model.error != null) {
      return SizedBox(
        key: const ValueKey("error"),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Icon(
            MdiIcons.exclamationThick,
            color: CustomColorsUtils.delete,
          ),
        ),
      );
    }

    if (model.loading) {
      return const SizedBox(
        key: ValueKey("loading"),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SizedBox(
            width: 15,
            height: 15,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      key: const ValueKey("content"),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomImage(
              source: CustomImageDataSource.file(
                model.picture.path,
                fit: BoxFit.cover,
                color: Colors.transparent,
              ),
              placeholder: const CustomImagePlaceholder(
                color: Colors.transparent,
              ),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.image_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      clipBehavior: Clip.hardEdge,
      child: Container(
        margin: margin,
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.grey.shade900,
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildChild(context),
              ),
            ),
            Positioned.fill(
              child: CustomAnimatedFadeVisibility(
                visible: selected,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColorsUtils.accent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: CustomRipple(
                hoverColor: Colors.white.withOpacity(0.1),
                splashColor: Colors.white.withOpacity(0.1),
                onPressed: onPressed == null ? null : () => onPressed?.call(model),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
