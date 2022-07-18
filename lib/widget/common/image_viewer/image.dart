import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/gesture_detector/index.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/image/model/placeholder.dart';

class CustomImageViewerImage extends StatefulWidget {
  final CustomImageDataSource dataSource;
  final String heroTag;
  final bool enableDrag;
  final Function(bool zoomed)? onZoomedChange;
  final Function()? close;
  final double? aspectRatio;
  final bool fromBoxFitCover;

  const CustomImageViewerImage({
    Key? key,
    required this.dataSource,
    this.heroTag = "",
    this.enableDrag = true,
    this.onZoomedChange,
    this.close,
    this.aspectRatio,
    this.fromBoxFitCover = false,

  }) : super(key: key);

  @override
  State<CustomImageViewerImage> createState() => CustomImageViewerImageState();
}

class CustomImageViewerImageState extends State<CustomImageViewerImage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationScale;
  late Animation<Offset> _animationTranslate;

  final _transformationController = TransformationController();
  Offset _totalDelta = Offset.zero;

  bool _zoomed = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _animationScale = Tween<double>(begin: 1.0, end: 1.0).animate(_animationController);
    _animationTranslate = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(_animationController);

    _transformationController.addListener(_onTransform);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomImageViewerImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.enableDrag != widget.enableDrag) {
      _reset();
    }
  }

  _onTransform() {
    bool zoomed = _zoomScale != 1.0;
    if (zoomed != _zoomed) {
      setState(() {
        _zoomed = zoomed;
      });
      widget.onZoomedChange?.call(zoomed);
    }
  }

  double get _zoomScale {
    return _transformationController.value.getColumn(0)[0];
  }

  bool get _canDrag {
    if (!widget.enableDrag) return false;
    return !_zoomed;
  }

  _animate({
    double? scale,
    Offset? translate,
    double? backgroundOpacity,
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
      backgroundOpacity: 1 - percentage,
      translate: _totalDelta,
    );
  }

  _onDragCancel(Offset pos) {
    _reset();
  }

  bool _closing = false;

  _onDragEnd(Offset pos) async {
    if (widget.close != null && _animationScale.value < 0.8) {
      if (widget.heroTag.trim().isEmpty) {
        if (_closing) return;
        _closing = true;

        final screenSize = MediaQuery.of(context).size.height;
        final h = screenSize * (_totalDelta.dy < 0 ? -1.0 : 1.0);
        await _animate(
          scale: 0.6,
          translate: Offset(0.0, h),
          duration: const Duration(milliseconds: 300),
        );
      }
      widget.close?.call();
    } else {
      _reset();
    }
  }

  _reset() {
    _animate(
      translate: Offset.zero,
      scale: 1.0,
      backgroundOpacity: 1.0,
      duration: const Duration(milliseconds: 300),
    );
  }

  double _map(double x, double inMin, double inMax, double outMin, double outMax) {
    return (x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }

  Widget _buildHero({required Widget child}) {
    if (widget.heroTag.trim().isEmpty) return child;

    return Hero(
      tag: widget.heroTag,
      flightShuttleBuilder: (
          flightContext,
          animation,
          flightDirection,
          fromHeroContext,
          toHeroContext,
          ) {
        final child = flightDirection == HeroFlightDirection.pop ? fromHeroContext.widget : toHeroContext.widget;
        if (!widget.fromBoxFitCover) return child;

        double ar = widget.aspectRatio!;
        if (ar < 1) {
          ar = 1 / widget.aspectRatio!;
        }

        return Container(
          color: Colors.transparent,
          child: ClipRRect(
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Transform.scale(
                scale: _map(animation.value, 0, 1, ar, 1),
                child: child,
              ),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      canDrag: () => _canDrag,
      onDragStart: _onDragStart,
      onDragUpdate: _onDragUpdate,
      onDragEnd: _onDragEnd,
      onDragCancel: _onDragCancel,
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
            child: CustomImage(
              source: CustomImageDataSource(
                type: widget.dataSource.type,
                data: widget.dataSource.data,
                fit: widget.dataSource.fit,
                color: Colors.transparent,
                bytes: widget.dataSource.bytes,
                imageProvider: widget.dataSource.imageProvider,
              ),
              placeholder: const CustomImagePlaceholder(
                icon: Icons.image_outlined,
                iconColor: Colors.white,
                color: Colors.transparent,
                iconSize: 40,
              ),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
