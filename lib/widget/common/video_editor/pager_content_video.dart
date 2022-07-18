import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/video.dart';
import 'package:truvideo_enterprise/core/widget.dart';
import 'package:truvideo_enterprise/model/camera/video_info.dart';
import 'package:truvideo_enterprise/model/video_editor/processing_video.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/video_player/controller.dart';
import 'package:truvideo_enterprise/widget/common/video_player/index.dart';
import 'package:truvideo_enterprise/widget/common/video_player/model/data.dart';
import 'package:truvideo_enterprise/widget/common/video_trimmer/index.dart';

import 'video_thumbnail_info.dart';

class CustomCameraVideoResultPagerContentVideo extends StatefulWidget {
  final VideoEditorProcessingVideoModel? video;
  final Function(Duration start)? onStartChange;
  final Function(Duration start)? onEndChange;
  final Function()? onButtonRetryPressed;

  const CustomCameraVideoResultPagerContentVideo({
    Key? key,
    required this.video,
    this.onStartChange,
    this.onEndChange,
    this.onButtonRetryPressed,
  }) : super(key: key);

  @override
  State<CustomCameraVideoResultPagerContentVideo> createState() => _CustomCameraVideoResultPagerContentVideoState();
}

class _CustomCameraVideoResultPagerContentVideoState extends State<CustomCameraVideoResultPagerContentVideo> with AutomaticKeepAliveClientMixin {
  final _controller = CustomVideoPlayerController();
  bool _loading = true;
  VideoInfoModel? _videoInfo;

  bool _dragging = false;
  final _position = ValueNotifier<Duration>(Duration.zero);
  final _start = ValueNotifier<Duration?>(null);
  final _end = ValueNotifier<Duration?>(null);
  bool _videoTrimmerVisible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if ((widget.video?.video.info.path ?? "").trim().isNotEmpty) {
        _init();
      }
    });
  }

  @override
  void didUpdateWidget(CustomCameraVideoResultPagerContentVideo oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newPath = widget.video?.video.info.path ?? "";
    final oldPath = oldWidget.video?.video.info.path ?? "";
    if (newPath != oldPath) {
      _init();
    }
  }

  _init() async {
    try {
      setState(() {
        _videoInfo = null;
        _loading = true;
      });

      final path = widget.video?.video.info.path ?? "";
      final info = await CustomVideoUtils.getInfo(path);
      if (!mounted) return;

      final videoDuration = Duration(milliseconds: info.durationMillis);
      _start.value = Duration.zero;
      _position.value = _start.value!;
      _end.value = videoDuration;

      setState(() {
        _videoInfo = info;
        _loading = false;
      });
    } catch (error) {
      log("Error fetching video data", error: error);
      if (!mounted) return;

      setState(() {
        _videoInfo = null;
        _loading = false;
      });
    }
  }

  _onVideoPositionChange(Duration position) {
    if (_dragging) return;
    _position.value = position;
  }

  _onThumbnailHandlerDragStart() {
    _dragging = true;
    _controller.pause();
  }

  _onThumbnailLeftHandlerDragEnd(Duration duration) async {
    _position.value = duration;
    _start.value = duration;
    await CustomWidgetUtils.wait();

    await _controller.seek(duration);

    _dragging = false;

    widget.onStartChange?.call(duration);
  }

  _onThumbnailRightHandlerDragEnd(Duration duration) async {
    _position.value = duration;
    _end.value = duration;
    await CustomWidgetUtils.wait();

    await _controller.seek(duration);

    _dragging = false;

    widget.onEndChange?.call(duration);
  }

  _onThumbnailCurrentPositionDragEnd(Duration duration) async {
    _position.value = duration;
    await CustomWidgetUtils.wait();

    await _controller.seek(duration);

    _dragging = false;
  }

  _onThumbnailPressed(Duration duration, double value) async {
    _dragging = true;
    _position.value = duration;
    await CustomWidgetUtils.wait();

    await _controller.pause();
    await _controller.seek(duration);

    _dragging = false;
  }

  _onVideoPressed() {
    if (_controller.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  Widget _buildError() {
    return Container(
      key: const ValueKey("error"),
      margin: const EdgeInsets.only(top: 75 + 16),
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
              "Error loading video",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            CustomBorderButton.small(
              text: "Retry",
              margin: const EdgeInsets.only(top: 16.0),
              borderColor: Colors.white.withOpacity(0.3),
              textColor: Colors.white,
              onPressed: widget.onButtonRetryPressed,
            )
          ],
        ),
      ),
    );
  }

  Widget get _child {
    if (widget.video?.error != null) {
      return _buildError();
    }

    final videoLoading = widget.video?.loading ?? false;
    if (videoLoading || _loading) {
      return Container(
        key: const ValueKey("loading"),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_videoInfo == null) {
      return _buildError();
    }

    final videoPath = widget.video?.video.info.path ?? "";
    return Container(
      key: const ValueKey("content"),
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          SizedBox(
            height: 75,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _videoTrimmerVisible
                  ? CustomVideoThumbnails(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      key: const ValueKey("thumbnails"),
                      borderRadius: 4.0,
                      contentBorderRadius: 0,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      videoPath: videoPath,
                      position: _position,
                      onLeftHandlerDragStart: _onThumbnailHandlerDragStart,
                      onLeftHandlerDragEnd: _onThumbnailLeftHandlerDragEnd,
                      onRightHandlerDragStart: _onThumbnailHandlerDragStart,
                      onRightHandlerDragEnd: _onThumbnailRightHandlerDragEnd,
                      onCurrentPositionDragStart: _onThumbnailHandlerDragStart,
                      onCurrentPositionDragEnd: _onThumbnailCurrentPositionDragEnd,
                      onPressed: _onThumbnailPressed,
                      infoBuilder: ({
                        required bool draggingHandler,
                        required bool draggingCurrent,
                        required Duration current,
                        required Duration start,
                        required Duration end,
                        required double startPosition,
                        required double endPosition,
                        required double currentPosition,
                      }) =>
                          CustomCameraVideoResultThumbnailInfo(
                        draggingCurrent: draggingCurrent,
                        draggingHandler: draggingHandler,
                        start: start,
                        end: end,
                        current: current,
                        position: _position,
                        currentPosition: currentPosition,
                        endPosition: endPosition,
                        startPosition: startPosition,
                      ),
                    )
                  : Container(key: const ValueKey("empty")),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: GestureDetector(
                onTap: _onVideoPressed,
                child: MultiValueListenableBuilder(
                  valueListenables: [_start, _end],
                  builder: (context, value, child) => CustomVideoPlayer(
                    source: CustomVideoPlayerDataSource.file(videoPath),
                    controller: _controller,
                    onPositionChange: _onVideoPositionChange,
                    minPosition: _start.value,
                    maxPosition: _end.value,
                    showControls: false,
                    onReady: () {
                      setState(() {
                        _videoTrimmerVisible = true;
                      });
                    },
                    builder: (context, value, controlsVisible) => Positioned.fill(
                      child: GestureDetector(
                        onTap: _onVideoPressed,
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: CustomAnimatedFadeVisibility(
                              visible: !(value?.isPlaying ?? false),
                              child: CustomButtonIcon(
                                size: 60,
                                elevation: 8,
                                focusedElevation: 16,
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                icon: Icons.play_arrow_outlined,
                                onPressed: _onVideoPressed,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
