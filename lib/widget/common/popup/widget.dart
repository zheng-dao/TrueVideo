import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/widget/common/popup/controller.dart';

class CustomPopupWidget extends StatefulWidget {
  final Widget Function(BuildContext context, CustomPopupController controller) builder;
  final double? left;
  final double? top;
  final double? right;
  final double width;
  final Function()? close;
  final double margin;
  final Alignment alignment;
  final CustomPopupController? controller;

  const CustomPopupWidget({
    Key? key,
    required this.builder,
    this.width = 200.0,
    this.close,
    this.margin = 16.0,
    this.alignment = Alignment.topRight,
    this.controller,
    this.left,
    this.top,
    this.right,
  }) : super(key: key);

  @override
  CustomPopupWidgetState createState() => CustomPopupWidgetState();
}

class CustomPopupWidgetState extends State<CustomPopupWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationOpacity;
  late Animation<double> _animationScale;
  late CustomPopupController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? CustomPopupController();
    _controller.attach(this);

    _animationController = AnimationController(vsync: this);
    _animationOpacity = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    _animationScale = Tween<double>(begin: 0.7, end: 0.7).animate(_animationController);
    CustomKeyboardUtils.hide();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    _controller.attach(null);
    _animationController.dispose();
    super.dispose();
  }

  _init() {
    _animate(
      opacity: 1.0,
      scale: 1.0,
      duration: const Duration(milliseconds: 300),
    );
  }

  _animate({
    double? opacity,
    double? scale,
    Duration duration = Duration.zero,
  }) async {
    _animationOpacity = Tween<double>(
      begin: _animationOpacity.value,
      end: opacity ?? _animationOpacity.value,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationScale = Tween<double>(
      begin: _animationScale.value,
      end: scale ?? _animationScale.value,
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
    if (_closing) return;
    _closing = true;

    await _animate(
      opacity: 0.0,
      scale: 0.7,
      duration: const Duration(milliseconds: 300),
    );
    widget.close?.call();
  }

  double get _top {
    return (widget.top ?? 0) + MediaQuery.of(context).padding.top;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      return WillPopScope(
        onWillPop: () async {
          close();
          return false;
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: close,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              left: widget.left,
              top: _top,
              right: widget.right,
              width: widget.width,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => Opacity(
                  opacity: _animationOpacity.value.clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: _animationScale.value,
                    alignment: widget.alignment,
                    child: child,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(widget.margin),
                  constraints: BoxConstraints(
                    maxHeight: c.maxHeight - _top - widget.margin * 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: kElevationToShadow[8],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: SingleChildScrollView(
                      child: widget.builder(context, _controller),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
