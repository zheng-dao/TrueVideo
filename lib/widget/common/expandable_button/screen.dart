import 'dart:async';

import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/widget.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';

class CustomExpandableButtonScreen extends StatefulWidget {
  final Size size;
  final Offset position;
  final Widget Function(BuildContext context, bool isOpen, Future<void> Function() open) buttonBuilder;
  final List<Widget> Function(BuildContext context, Future<void> Function() close) buttonsBuilder;
  final Widget Function(BuildContext context, int index)? labelBuilder;
  final Color? backgroundColor;

  const CustomExpandableButtonScreen({
    Key? key,
    required this.size,
    required this.position,
    required this.buttonBuilder,
    required this.buttonsBuilder,
    this.backgroundColor,
    this.labelBuilder,
  }) : super(key: key);

  @override
  State<CustomExpandableButtonScreen> createState() => CustomExpandableButtonScreenState();
}

class CustomExpandableButtonScreenState extends State<CustomExpandableButtonScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacity;
  late Animation<double> _buttonScale;
  late Animation<double> _buttonOpacity;
  bool _isOpen = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _opacity = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    _buttonScale = Tween<double>(begin: 0.7, end: 0.7).animate(_animationController);
    _buttonOpacity = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _isOpen = true;
      });

      _animate(true);
    });
  }

  Future<void> _animate(bool open) async {
    _opacity = Tween<double>(
      begin: _opacity.value,
      end: open ? 1.0 : 0.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _buttonScale = Tween<double>(
      begin: _buttonScale.value,
      end: open ? 1.0 : 0.7,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _buttonOpacity = Tween<double>(
      begin: _buttonOpacity.value,
      end: open ? 1.0 : 0.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.stop();
    _animationController.reset();
    _animationController.duration = const Duration(milliseconds: 300);
    await _animationController.forward();
  }

  bool _closing = false;

  Future<void> close() async {
    if (_closing) {
      return;
    }

    setState(() {
      _isOpen = false;
      _closing = true;
    });

    await CustomWidgetUtils.wait();

    await _animate(false);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final buttons = widget.buttonsBuilder(context, close);

    return IgnorePointer(
      ignoring: _closing,
      child: CustomScaffold(
        onWillPop: () async {
          close();
          return false;
        },
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: close,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => Opacity(
                    opacity: _opacity.value,
                    child: child,
                  ),
                  child: Container(
                    color: widget.backgroundColor ?? Colors.transparent,
                  ),
                ),
              ),
            ),
            Positioned(
              left: widget.position.dx,
              top: widget.position.dy,
              width: widget.size.width,
              height: widget.size.height,
              child: widget.buttonBuilder(context, _isOpen, () async {
                await close();
              }),
            ),
            Positioned(
              left: widget.position.dx + widget.size.width,
              top: widget.position.dy - 8.0,
              child: FractionalTranslation(
                translation: const Offset(-1.0, -1.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  runSpacing: 8.0,
                  spacing: 8.0,
                  direction: Axis.vertical,
                  children: [
                    for (int i = 0; i < buttons.length; i++)
                      Builder(
                        builder: (context) {
                          final label = widget.labelBuilder?.call(context, i);
                          return Row(
                            children: [
                              if (label != null)
                                AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) => Opacity(
                                    opacity: _buttonOpacity.value,
                                    child: Transform.scale(
                                      scale: _buttonScale.value,
                                      alignment: Alignment.centerRight,
                                      child: child,
                                    ),
                                  ),
                                  child: label,
                                ),
                              AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) => Opacity(
                                  opacity: _buttonOpacity.value,
                                  child: Transform.scale(
                                    scale: _buttonScale.value,
                                    alignment: Alignment.center,
                                    child: child,
                                  ),
                                ),
                                child: buttons[i],
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
