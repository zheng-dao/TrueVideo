import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/widget.dart';
import 'package:truvideo_enterprise/widget/common/bottom_sheet/controller.dart';

class CustomBottomSheet extends StatefulWidget {
  final Function()? close;
  final bool Function()? canClose;

  final double bounce;
  final bool dragEnabled;
  final CustomBottomSheetController? controller;
  final Widget Function(BuildContext context, CustomBottomSheetController controller) builder;
  final Duration duration;
  final Curve curve;

  const CustomBottomSheet({
    Key? key,
    this.close,
    this.dragEnabled = true,
    this.bounce = 20.0,
    required this.builder,
    this.canClose,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.decelerate,
    this.controller,
  }) : super(key: key);

  @override
  CustomBottomSheetState createState() => CustomBottomSheetState();
}

class CustomBottomSheetState extends State<CustomBottomSheet> with SingleTickerProviderStateMixin {
  late CustomBottomSheetController _controller;
  late AnimationController _animationController;
  late Animation<Offset> _animationPosition;
  late Animation<double> _animationBackground;
  bool _render = false;

  @override
  void initState() {
    _controller = widget.controller ?? CustomBottomSheetController();
    _controller.attach(this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    _controller.attach(null);
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.dragEnabled) {
      _animate(
        position: Offset.zero,
        background: 1.0,
        duration: widget.duration,
      );
    }
  }

  _init() async {
    _animationController = AnimationController(vsync: this);
    _animationPosition = Tween<Offset>(
      begin: Offset(0, MediaQuery.of(context).size.height),
      end: Offset(0, MediaQuery.of(context).size.height),
    ).animate(_animationController);
    _animationBackground = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    _render = true;
    setState(() {});

    await CustomWidgetUtils.wait();
    _animate(
      position: Offset.zero,
      background: 1.0,
      duration: widget.duration,
    );
  }

  _animate({
    Offset? position,
    double? background,
    Duration duration = Duration.zero,
  }) async {
    _animationPosition = Tween<Offset>(
      begin: _animationPosition.value,
      end: position ?? _animationPosition.value,
    ).animate(CurvedAnimation(parent: _animationController, curve: widget.curve));

    _animationBackground = Tween<double>(
      begin: _animationBackground.value,
      end: background ?? _animationBackground.value,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    if (duration == Duration.zero) {
      _animationController.value = 1.0;
    } else {
      _animationController.reset();
      _animationController.duration = duration;
      await _animationController.forward();
    }
  }

  bool _closing = false;

  close() async {
    final canClose = widget.canClose?.call() ?? false;
    if (canClose) {
      if (_closing) return;
      _closing = true;

      await _animate(
        position: Offset(0.0, MediaQuery.of(context).size.height),
        background: 0.0,
        duration: widget.duration,
      );
      widget.close?.call();
    } else {
      _animate(
        position: Offset.zero,
        duration: widget.duration,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_render) return Container();

    return WillPopScope(
      onWillPop: () async {
        close();
        return false;
      },
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Background
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) => Opacity(
                opacity: _animationBackground.value.clamp(0.0, 1.0),
                child: GestureDetector(
                  onTap: close,
                  child: Container(color: Colors.black.withOpacity(0.7)),
                ),
              ),
            ),
            // Content
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: -widget.bounce,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => Transform.translate(
                  offset: _animationPosition.value,
                  child: child!,
                ),
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    if (!widget.dragEnabled) return;

                    double dy = _animationPosition.value.dy + details.delta.dy;
                    dy = dy.clamp(-widget.bounce, MediaQuery.of(context).size.height);
                    _animate(position: Offset(0.0, dy));
                  },
                  onVerticalDragEnd: (details) {
                    if (!widget.dragEnabled) return;

                    bool delta = _animationPosition.value.dy > MediaQuery.of(context).size.height * 0.4;
                    bool speed = (details.primaryVelocity ?? 0.0) > 1000;
                    if (delta || speed) {
                      close();
                    } else {
                      _animate(
                        position: Offset.zero,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top),
                      const Spacer(),
                      Center(
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 5,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: kElevationToShadow[4],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: widget.bounce + MediaQuery.of(context).viewPadding.bottom),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                          color: Theme.of(context).cardColor,
                          boxShadow: kElevationToShadow[8],
                        ),
                        child: widget.builder(context, _controller),
                      ),
                    ],
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
