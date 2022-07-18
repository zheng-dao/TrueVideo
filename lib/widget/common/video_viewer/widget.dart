import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/gesture_detector/index.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/video_player/controller.dart';
import 'package:truvideo_enterprise/widget/common/video_player/index.dart';
import 'package:truvideo_enterprise/widget/common/video_player/model/data.dart';

class CustomVideoViewerWidget extends StatefulHookConsumerWidget {
  final CustomVideoPlayerDataSource source;
  final CustomImageDataSource? thumbnail;
  final String thumbnailHeroTag;
  final bool fromBoxFitCover;
  final double? aspectRatio;

  const CustomVideoViewerWidget({
    Key? key,
    required this.source,
    this.thumbnail,
    this.thumbnailHeroTag = "",
    this.fromBoxFitCover = false,
    this.aspectRatio,
  }) : super(key: key);

  @override
  ConsumerState<CustomVideoViewerWidget> createState() => _CustomVideoViewerWidgetState();
}

class _CustomVideoViewerWidgetState extends ConsumerState<CustomVideoViewerWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationScale;
  late Animation<Offset> _animationTranslate;

  bool _controlsVisible = false;
  final _videoController = CustomVideoPlayerController();

  final _transformationController = TransformationController();
  Offset _totalDelta = Offset.zero;
  bool _zoomed = false;
  bool _closing = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _animationScale = Tween<double>(begin: 1.0, end: 1.0).animate(_animationController);
    _animationTranslate = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(_animationController);

    _transformationController.addListener(_onTransform);

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      _videoController.controlsVisible = true;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  _close() async {
    Navigator.of(context).pop();
  }

  _onTransform() {
    bool zoomed = _zoomScale != 1.0;
    if (zoomed != _zoomed) {
      setState(() {
        _zoomed = zoomed;
      });
    }
  }

  double get _zoomScale {
    return _transformationController.value.getColumn(0)[0];
  }

  bool get _canDrag {
    return !_zoomed;
  }

  _onControlsVisibilityChange(bool visible) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _controlsVisible = visible;
      });
    });
  }

  _animate({
    double? scale,
    Offset? translate,
    Duration? duration,
  }) async {
    _animationScale = Tween<double>(
      begin: _animationScale.value,
      end: scale ?? _animationScale.value,
    ).animate(_animationController);

    _animationTranslate = Tween<Offset>(
      begin: _animationTranslate.value,
      end: translate ?? _animationTranslate.value,
    ).animate(_animationController);

    if (duration == null || duration == Duration.zero) {
      _animationController.value = 1.0;
    } else {
      _animationController.reset();
      _animationController.duration = duration;
      await _animationController.forward();
    }
  }

  _onDragStart(Offset pos) {
    _totalDelta = Offset.zero;
  }

  _onDragUpdate(Offset delta) async {
    delta = Offset(0.0, delta.dy);

    _totalDelta += delta;
    final size = MediaQuery.of(context).size;
    final deltaY = _totalDelta.dy.abs() / size.height;
    final percentage = deltaY.clamp(0.0, 1.0);

    _animate(
      scale: 1 - percentage,
      translate: _totalDelta,
    );
  }

  _onDragCancel(Offset pos) {
    _reset();
  }

  _onDragEnd(Offset pos) async {
    if (_animationScale.value < 0.8) {
      if (_closing) return;
      _closing = true;

      _videoController.controlsVisible = false;

      if (widget.thumbnail != null && widget.thumbnailHeroTag.trim().isNotEmpty) {
        _close();
      } else {
        final screenSize = MediaQuery.of(context).size.height;
        final h = screenSize * (_totalDelta.dy < 0 ? -1.0 : 1.0);
        await _animate(
          scale: 0.6,
          translate: Offset(0.0, h),
          duration: const Duration(milliseconds: 300),
        );
        _close();
      }
    } else {
      _reset();
    }
  }

  _reset() {
    _animate(
      translate: Offset.zero,
      scale: 1.0,
      duration: const Duration(milliseconds: 300),
    );
  }

  double _map(double x, double inMin, double inMax, double outMin, double outMax) {
    return (x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }

  Widget _buildHero({required Widget child}) {
    final thumbnail = widget.thumbnail;
    if (thumbnail == null || widget.thumbnailHeroTag.trim().isEmpty) return child;

    return Hero(
      tag: widget.thumbnailHeroTag,
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        double ar;
        if (widget.fromBoxFitCover) {
          ar = widget.aspectRatio!;
          if (ar < 1) {
            ar = 1 / widget.aspectRatio!;
          }
        } else {
          ar = 1;
        }

        final a = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
        );

        return Container(
          color: Colors.black,
          child: ClipRRect(
            child: AnimatedBuilder(
              animation: a,
              builder: (context, child) => Transform.scale(
                scale: _map(a.value, 0, 1, ar, 1),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: flightDirection == HeroFlightDirection.push ? animation.value : 0.0,
                        child: const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Opacity(
                        opacity: flightDirection == HeroFlightDirection.push ? 1 - animation.value : 1.0,
                        child: CustomImage(
                          width: double.infinity,
                          height: double.infinity,
                          source: CustomImageDataSource(
                            type: thumbnail.type,
                            color: Colors.transparent,
                            fit: BoxFit.contain,
                            imageProvider: thumbnail.imageProvider,
                            data: thumbnail.data,
                            bytes: thumbnail.bytes,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    useEffect(
      () {
        if (_controlsVisible || !Platform.isIOS) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        }
        return () {};
      },
      [_controlsVisible],
    );

    return CustomScaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appbar: CustomAppBar(
        backgroundColor: Colors.transparent,
        leading: CustomAnimatedFadeVisibility(
          visible: _controlsVisible,
          child: CustomButtonIcon(
            icon: Icons.clear,
            iconColor: Colors.white,
            elevation: 0,
            backgroundColor: Colors.black.withOpacity(0.6),
            onPressed: _close,
          ),
        ),
      ),
      body: CustomGestureDetector(
        canDrag: () => _canDrag,
        onDragStart: _onDragStart,
        onDragUpdate: _onDragUpdate,
        onDragEnd: _onDragEnd,
        onDragCancel: _onDragCancel,
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => Transform.translate(
                  offset: _animationTranslate.value,
                  child: Transform.scale(
                    scale: _animationScale.value,
                    child: child,
                  ),
                ),
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  child: _buildHero(
                    child: CustomVideoPlayer(
                      color: Colors.transparent,
                      controller: _videoController,
                      source: widget.source,
                      autoPlay: true,
                      zoomable: false,
                      showControlsOnInitialize: false,
                      controlsMargin: const EdgeInsets.all(16.0).copyWith(
                        bottom: mq.viewPadding.bottom + 16.0,
                        left: mq.padding.left + 16.0,
                        right: mq.padding.right + 16.0,
                      ),
                      onControlsVisibilityChange: _onControlsVisibilityChange,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: IgnorePointer(
                ignoring: true,
                child: CustomAnimatedFadeVisibility(
                  visible: _controlsVisible,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: MediaQuery.of(context).padding.top,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
