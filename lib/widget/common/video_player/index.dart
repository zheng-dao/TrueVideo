import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:truvideo_enterprise/core/widget.dart';
import 'package:video_player/video_player.dart';

import 'controller.dart';
import 'controls.dart';
import 'model/data.dart';

class CustomVideoPlayer extends StatefulHookConsumerWidget {
  final CustomVideoPlayerDataSource? source;
  final CustomVideoPlayerController? controller;
  final Duration? maxPosition;
  final Duration? minPosition;
  final Function(Duration duration)? onPositionChange;
  final bool showControls;
  final Widget Function(BuildContext context, VideoPlayerValue? value, bool controlsVisible)? builder;
  final Function()? onReady;
  final bool zoomable;
  final bool showControlsOnInitialize;
  final bool enableFullscreen;
  final EdgeInsets? controlsMargin;
  final bool hideControlsOnPress;
  final bool autoPlay;
  final Function(bool visible)? onControlsVisibilityChange;
  final Color color;

  const CustomVideoPlayer({
    Key? key,
    this.zoomable = true,
    this.color = Colors.black,
    this.source,
    this.controller,
    this.maxPosition,
    this.minPosition,
    this.onPositionChange,
    this.showControls = true,
    this.builder,
    this.onReady,
    this.showControlsOnInitialize = true,
    this.enableFullscreen = false,
    this.controlsMargin,
    this.hideControlsOnPress = true,
    this.autoPlay = false,
    this.onControlsVisibilityChange,
  }) : super(key: key);

  @override
  CustomVideoPlayerState createState() => CustomVideoPlayerState();
}

class CustomVideoPlayerState extends ConsumerState<CustomVideoPlayer> {
  late CustomVideoPlayerController _controller;
  ChewieController? _chewieController;
  VideoPlayerController? _videoPlayerController;
  final _position = ValueNotifier<Duration>(Duration.zero);
  bool _ready = false;
  bool _error = false;
  bool _controlsVisible = true;
  Timer? _timer;

  @override
  void initState() {
    _controlsVisible = widget.showControlsOnInitialize;
    widget.onControlsVisibilityChange?.call(_controlsVisible);
    _initController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _config());
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.attach(null);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source != widget.source) {
      _config();
    }

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.attach(null);
      _initController();
    }
  }

  _initController() {
    _controller = widget.controller ?? CustomVideoPlayerController();
    _controller.attach(this);
  }

  set controlsVisible(bool value) {
    if (value) {
      _showControls();
    } else {
      _hideControls();
    }
  }

  _cancel() async {
    _timer?.cancel();

    final oldVideoPlayerController = _videoPlayerController;
    final oldChewieController = _chewieController;

    _hideControls();
    setState(() {
      _ready = false;
      _error = false;
      _videoPlayerController = null;
      _videoPlayerController = null;
    });

    await CustomWidgetUtils.wait();
    if (oldVideoPlayerController != null) {
      oldVideoPlayerController.removeListener(_onPositionChanged);
      await oldVideoPlayerController.dispose();
    }

    if (oldChewieController != null) {
      oldChewieController.dispose();
    }

    if (!mounted) return;
    setState(() {
      _ready = false;
    });
    await CustomWidgetUtils.wait(duration: 100);
  }

  _config() async {
    _stopPositionListener();
    _position.value = widget.minPosition ?? Duration.zero;
    _reportPosition(_position.value);

    setState(() {
      _ready = false;
      _error = false;
    });

    await _cancel();
    if (!mounted) return;

    if (widget.source == null) {
      return;
    }

    try {
      VideoPlayerController videoPlayerController;
      if (widget.source!.isFile) {
        videoPlayerController = VideoPlayerController.file(File(widget.source!.data));
      } else {
        videoPlayerController = VideoPlayerController.network(widget.source!.data);
      }
      await videoPlayerController.initialize();
      final chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        useRootNavigator: true,
        allowedScreenSleep: false,
        allowFullScreen: widget.enableFullscreen,
        allowMuting: false,
        autoInitialize: true,
        deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeRight],
        zoomAndPan: widget.zoomable,
        showControls: false,
        autoPlay: widget.autoPlay,
        showControlsOnInitialize: widget.showControlsOnInitialize,
        allowPlaybackSpeedChanging: false,
      );

      videoPlayerController.addListener(() {
        if (!mounted) return;
        setState(() {});
      });

      if (!mounted) {
        videoPlayerController.dispose();
        chewieController.dispose();
        return;
      }

      setState(() {
        _chewieController = chewieController;
        _videoPlayerController = videoPlayerController;
      });

      _listenPosition();
      _ready = true;

      widget.onReady?.call();

      if (widget.showControls) {
        _showControls();
      }
    } catch (error, stack) {
      log("Error init video player", error: error, stackTrace: stack);
      if (!mounted) return;
      await _cancel();

      setState(() {
        _error = true;
        _ready = false;
      });
    }
  }

  _showControls() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _controlsVisible = false;
      });
    });

    setState(() {
      _controlsVisible = true;
    });
  }

  _hideControls() {
    _timer?.cancel();
    setState(() {
      _controlsVisible = false;
    });
  }

  _stopPositionListener() {
    _videoPlayerController?.removeListener(_onPositionChanged);
  }

  _listenPosition() {
    _videoPlayerController?.addListener(_onPositionChanged);
  }

  _onPositionChanged() async {
    final pos = _videoPlayerController?.value.position;
    if (pos == null) return;
    if (pos == _position.value) return;

    if (widget.maxPosition != null && pos >= widget.maxPosition!) {
      _stopPositionListener();
      await _controller.pause();
      await _controller.seek(widget.maxPosition!);
      _position.value = widget.maxPosition!;
      _reportPosition(widget.maxPosition!);
      _listenPosition();
    } else {
      _position.value = pos;
      _reportPosition(_position.value);
    }
  }

  _reportPosition(Duration duration) {
    widget.onPositionChange?.call(duration);
  }

  Future<void> play() async {
    if (!_ready) return;

    await _videoPlayerController?.pause();

    if (widget.maxPosition != null && _position.value >= widget.maxPosition!) {
      final pos = widget.minPosition ?? Duration.zero;
      await _videoPlayerController?.seekTo(pos);
    }

    await _videoPlayerController?.play();
  }

  Future<void> pause() async {
    if (!_ready) return;
    await _videoPlayerController?.pause();
  }

  Future<void> seek(Duration position) async {
    if (!_ready) return;

    final d = _videoPlayerController!.value.duration.inMilliseconds;
    final m = position.inMilliseconds.clamp(widget.minPosition?.inMilliseconds ?? 0, widget.maxPosition?.inMilliseconds ?? d);
    position = Duration(milliseconds: m);
    await _videoPlayerController?.seekTo(position);
  }

  bool get isPlaying {
    if (!_ready) return false;
    return _videoPlayerController?.value.isPlaying ?? false;
  }

  Widget _buildPlaceholder() {
    return Container(
      key: const ValueKey("loading"),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      key: const ValueKey("error"),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: Icon(
            MdiIcons.exclamationThick,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildZoomableWidget({required Widget child}) {
    if (!widget.zoomable) return child;
    return InteractiveViewer(
      child: child,
    );
  }

  Widget _buildChild() {
    Widget child;

    if (_error) {
      child = _buildError();
    } else {
      if (_videoPlayerController == null || _chewieController == null || !_ready || !_videoPlayerController!.value.isInitialized) {
        child = _buildPlaceholder();
      } else {
        final state = _videoPlayerController!.value;
        child = Stack(
          key: const ValueKey("video"),
          children: [
            _buildZoomableWidget(
              child: IgnorePointer(
                ignoring: true,
                child: Chewie(
                  controller: _chewieController!,
                ),
              ),
            ),
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  if (widget.hideControlsOnPress) {
                    log("Tap $_controlsVisible");

                    if (_controlsVisible) {
                      _hideControls();
                    } else {
                      _showControls();
                    }
                  }
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomVideoPlayerControls(
                visible: _controlsVisible && widget.showControls,
                margin: widget.controlsMargin ?? const EdgeInsets.all(16.0),
                playing: state.isPlaying,
                position: state.position.inMilliseconds,
                duration: state.duration.inMilliseconds,
                onSeekStart: () {
                  _timer?.cancel();
                  setState(() {
                    _controlsVisible = true;
                  });
                },
                onSeekEnd: () {
                  _showControls();
                },
                seek: (pos) async {
                  await seek(Duration(milliseconds: pos));
                },
                onPlayPressed: () {
                  _showControls();

                  if (state.isPlaying) {
                    pause();
                  } else {
                    play();
                  }
                },
              ),
            ),
          ],
        );
      }
    }

    final value = _videoPlayerController?.value;
    return Stack(
      children: [
        child,
        if (widget.builder != null) widget.builder!.call(context, value, value == null ? true : _controlsVisible),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        widget.onControlsVisibilityChange?.call(_controlsVisible);
        return () {};
      },
      [_controlsVisible],
    );

    return Container(
      color: widget.color,
      child: _buildChild(),
    );
  }
}
