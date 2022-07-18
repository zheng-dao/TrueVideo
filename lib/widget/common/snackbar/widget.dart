import 'dart:async';

import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';

class CustomSnackBack extends StatefulWidget {
  final Color? backgroundColor;
  final String title;
  final Color? titleColor;
  final String message;
  final Color? messageColor;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Function()? close;

  const CustomSnackBack({
    Key? key,
    this.backgroundColor,
    this.title = "",
    this.titleColor,
    this.message = "",
    this.messageColor,
    this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.close,
  }) : super(key: key);

  @override
  CustomSnackBackState createState() => CustomSnackBackState();
}

class CustomSnackBackState extends State<CustomSnackBack> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animationPosition;
  late Animation<double> _animationOpacity;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    _animationPosition = Tween<Offset>(begin: const Offset(0, -200), end: const Offset(0, -200)).animate(_animationController);
    _animationOpacity = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _startTimer();
      _animate(
        translate: Offset.zero,
        opacity: 1.0,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _startTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      close();
    });
  }

  _animate({
    Offset? translate,
    double? opacity,
    Duration duration = Duration.zero,
  }) async {
    _animationPosition = Tween<Offset>(
      begin: _animationPosition.value,
      end: translate ?? _animationPosition.value,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationOpacity = Tween<double>(
      begin: _animationOpacity.value,
      end: opacity ?? _animationOpacity.value,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    if (duration == Duration.zero) {
      _animationController.value = 1.0;
    } else {
      _animationController.reset();
      _animationController.duration = duration;
      await _animationController.forward();
    }
  }

  Future<void> close() async {
    _timer?.cancel();

    await _animate(
      translate: const Offset(0, -200),
      opacity: 0.0,
      duration: const Duration(milliseconds: 300),
    );

    widget.close?.call();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.backgroundColor ?? Theme.of(context).cardColor;
    final textColor = backgroundColor.contrast(context);
    final iconBackgroundColor = widget.iconBackgroundColor ?? Theme.of(context).dividerColor;
    final iconColor = widget.iconColor ?? iconBackgroundColor.contrast(context);

    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: 150,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => Opacity(
              opacity: _animationOpacity.value.clamp(0.0, 1.0),
              child: child,
            ),
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Positioned(
            left: 0,
            right: 0,
            top: _animationPosition.value.dy,
            child: child!,
          ),
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: GestureDetector(
              onVerticalDragStart: (details) {
                _timer?.cancel();
              },
              onVerticalDragUpdate: (details) {
                final y = (_animationPosition.value.dy + details.delta.dy).clamp(-200.0, 20.0);
                _animate(
                  translate: Offset(0, y),
                );
              },
              onVerticalDragEnd: (details) {
                if (_animationPosition.value.dy < -30 || (details.primaryVelocity ?? 0.0) < -500) {
                  close();
                } else {
                  _animate(
                    translate: Offset.zero,
                    duration: const Duration(milliseconds: 300),
                  );

                  _startTimer();
                }
              },
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: RawMaterialButton(
                  onPressed: () => close(),
                  fillColor: backgroundColor,
                  elevation: 8,
                  padding: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide.none,
                  ),
                  splashColor: backgroundColor.contrast(context).withOpacity(0.1),
                  highlightColor: Colors.transparent,
                  child: Row(
                    children: [
                      if (widget.icon != null)
                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: iconBackgroundColor,
                          ),
                          child: Icon(
                            widget.icon,
                            color: iconColor,
                          ),
                        ),
                      Expanded(
                        child: DefaultTextStyle(
                          style: TextStyle(color: textColor),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (widget.title.trim().isNotEmpty)
                                Text(
                                  widget.title,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              if (widget.message.trim().isNotEmpty) Text(widget.message),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
