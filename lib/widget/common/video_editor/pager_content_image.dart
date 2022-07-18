import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/video_editor/processing_picture.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/image/model/placeholder.dart';

class CustomCameraVideoResultPagerContentPicture extends StatefulWidget {
  final VideoEditorProcessingPictureModel model;
  final Function(VideoEditorProcessingPictureModel model)? onRetryPressed;
  final Function(VideoEditorProcessingPictureModel model)? onButtonRotateLeftPressed;
  final Function(VideoEditorProcessingPictureModel model)? onButtonRotateRightPressed;
  final Function(VideoEditorProcessingPictureModel model)? onButtonFlipHorizontalPressed;
  final Function(VideoEditorProcessingPictureModel model)? onButtonFlipVerticalPressed;

  const CustomCameraVideoResultPagerContentPicture({
    Key? key,
    required this.model,
    this.onRetryPressed,
    this.onButtonRotateLeftPressed,
    this.onButtonRotateRightPressed,
    this.onButtonFlipHorizontalPressed,
    this.onButtonFlipVerticalPressed,
  }) : super(key: key);

  @override
  State<CustomCameraVideoResultPagerContentPicture> createState() => _CustomCameraVideoResultPagerContentPictureState();
}

class _CustomCameraVideoResultPagerContentPictureState extends State<CustomCameraVideoResultPagerContentPicture> with AutomaticKeepAliveClientMixin {
  Widget get _child {
    if (widget.model.error != null) {
      return Container(
        key: const ValueKey("error"),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: CustomColorsUtils.delete.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  MdiIcons.exclamationThick,
                  color: CustomColorsUtils.delete,
                  size: 40,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Error loading picture",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
              CustomBorderButton.small(
                margin: const EdgeInsets.only(top: 16.0),
                borderColor: Colors.white.withOpacity(0.3),
                textColor: Colors.white,
                text: "Retry",
                onPressed: () => widget.onRetryPressed?.call(widget.model),
              ),
            ],
          ),
        ),
      );
    }

    if (widget.model.loading) {
      return Container(
        key: const ValueKey("loading"),
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
    }

    return Container(
      key: const ValueKey("content"),
      child: Container(
        margin: const EdgeInsets.all(16.0).copyWith(top: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
        ),
        clipBehavior: Clip.hardEdge,
        child: InteractiveViewer(
          child: CustomImage(
            width: double.infinity,
            height: double.infinity,
            source: CustomImageDataSource.file(
              widget.model.picture.path,
              fit: BoxFit.contain,
              color: Colors.transparent,
            ),
            placeholder: const CustomImagePlaceholder(
              color: Colors.transparent,
              icon: Icons.image_outlined,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        CustomAnimatedFadeVisibility(
          minOpacity: 0.5,
          visible: !widget.model.loading && widget.model.error == null,
          child: Container(
            height: 75,
            color: Colors.transparent,
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomButtonIcon(
                  tooltip: "Rotate to left",
                  backgroundColor: Colors.grey.shade800,
                  iconColor: Colors.white,
                  icon: MdiIcons.rotateLeft,
                  onPressed: () => widget.onButtonRotateLeftPressed?.call(widget.model),
                ),
                const SizedBox(width: 4.0),
                CustomButtonIcon(
                  tooltip: "Rotate to right",
                  backgroundColor: Colors.grey.shade800,
                  iconColor: Colors.white,
                  icon: MdiIcons.rotateRight,
                  onPressed: () => widget.onButtonRotateRightPressed?.call(widget.model),
                ),
                const SizedBox(width: 4.0),
                CustomButtonIcon(
                  tooltip: "Flip horizontal",
                  backgroundColor: Colors.grey.shade800,
                  iconColor: Colors.white,
                  icon: MdiIcons.flipHorizontal,
                  onPressed: () => widget.onButtonFlipHorizontalPressed?.call(widget.model),
                ),
                const SizedBox(width: 4.0),
                CustomButtonIcon(
                  tooltip: "Flip vertical",
                  backgroundColor: Colors.grey.shade800,
                  iconColor: Colors.white,
                  icon: MdiIcons.flipVertical,
                  onPressed: () => widget.onButtonFlipVerticalPressed?.call(widget.model),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _child,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
