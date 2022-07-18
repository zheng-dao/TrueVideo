// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/src/utils/scroll_to_top_status_bar.dart';

import 'package:modal_bottom_sheet/src/utils/bottom_sheet_suspended_curve.dart';

const Curve _decelerateEasing = Cubic(0.0, 0.0, 0.2, 1.0);
const Curve _modalBottomSheetCurve = _decelerateEasing;

const double _minFlingVelocity = 500.0;
const double _closeProgressThreshold = 0.6;
const double _willPopThreshold = 0.8;

typedef WidgetWithChildBuilder = Widget Function(BuildContext context, Animation<double> animation, Widget child);

/// A custom bottom sheet.
///
/// The [ModalBottomSheet] widget itself is rarely used directly. Instead, prefer to
/// create a modal bottom sheet with [showMaterialModalBottomSheet].
///
/// See also:
///
///  * [showMaterialModalBottomSheet] which can be used to display a modal bottom
///    sheet with Material appareance.
///  * [showCupertinoModalBottomSheet] which can be used to display a modal bottom
///    sheet with Cupertino appareance.
class ModalBottomSheet extends StatefulWidget {
  /// Creates a bottom sheet.
  const ModalBottomSheet({
    Key? key,
    this.closeProgressThreshold,
    required this.animationController,
    this.animationCurve,
    required this.canDrag,
    this.containerBuilder,
    required this.scrollController,
    required this.expanded,
    required this.onClosing,
    required this.child,
    required this.duration,
  }) : super(key: key);

  final Duration duration;

  /// The closeProgressThreshold parameter
  /// specifies when the bottom sheet will be dismissed when user drags it.
  final double? closeProgressThreshold;

  /// The animation controller that controls the bottom sheet's entrance and
  /// exit animations.
  ///
  /// The BottomSheet widget will manipulate the position of this animation, it
  /// is not just a passive observer.
  final AnimationController animationController;

  /// The curve used by the animation showing and dismissing the bottom sheet.
  ///
  /// If no curve is provided it falls back to `decelerateEasing`.
  final Curve? animationCurve;

  // Force the widget to fill the maximum size of the viewport
  // or if false it will fit to the content of the widget
  final bool expanded;

  final WidgetWithChildBuilder? containerBuilder;

  /// Called when the bottom sheet begins to close.
  ///
  /// A bottom sheet might be prevented from closing (e.g., by user
  /// interaction) even after this callback is called. For this reason, this
  /// callback might be call multiple times for a given bottom sheet.
  final Function() onClosing;

  /// A builder for the contents of the sheet.
  ///
  final Widget child;

  /// If true, the bottom sheet can be dragged up and down and dismissed by
  /// swiping downwards.
  ///
  /// Default is true.
  final bool Function() canDrag;

  final ScrollController scrollController;

  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();

  /// Creates an [AnimationController] suitable for a
  /// [ModalBottomSheet.animationController].
  ///
  /// This API available as a convenience for a Material compliant bottom sheet
  /// animation. If alternative animation durations are required, a different
  /// animation controller could be provided.
  static AnimationController createAnimationController(
    TickerProvider vsync, {
    Duration? duration,
  }) {
    return AnimationController(
      duration: duration,
      debugLabel: 'BottomSheet',
      vsync: vsync,
    );
  }
}

class _ModalBottomSheetState extends State<ModalBottomSheet> with TickerProviderStateMixin {
  final GlobalKey _childKey = GlobalKey(debugLabel: 'BottomSheet child');

  ScrollController get _scrollController => widget.scrollController;

  @override
  void initState() {
    animationCurve = _defaultCurve;
    super.initState();
  }

  double? get _childHeight {
    final childContext = _childKey.currentContext;
    final renderBox = childContext?.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  bool get hasReachedWillPopThreshold => widget.animationController.value < _willPopThreshold;

  bool get hasReachedCloseThreshold => widget.animationController.value < (widget.closeProgressThreshold ?? _closeProgressThreshold);

  void _close() {
    final value = widget.animationController.value;
    widget.animationController.stop();
    widget.animationController.duration = widget.duration;
    widget.animationController.reset();
    widget.animationController.value = value;

    _dragging = false;
    widget.onClosing();
  }

  void _cancelClose() async {
    final val = widget.animationController.value;

    widget.animationController.stop();
    widget.animationController.duration = Duration(milliseconds: 2000);
    widget.animationController.reset();
    await widget.animationController.forward(from: val);

    if (!mounted) return;

    widget.animationController.stop();
    widget.animationController.duration = widget.duration;
    widget.animationController.reset();
    await widget.animationController.forward(from: 1);

    // When using WillPop, animation doesn't end at 1.
    // Check more in detail the problem
    if (!widget.animationController.isCompleted) {
      widget.animationController.value = 1;
    }
  }

  ParametricCurve<double> animationCurve = Curves.linear;

  bool _dragging = false;

  void _handleDragUpdate(double primaryDelta) async {
    final enableDrag = widget.canDrag();
    if (!enableDrag) return;
    if (_scrollController.positions.length > 1) return;

    double pos;
    if (!_scrollController.hasClients) {
      pos = 0.0;
      _dragging = true;
    } else {
      if (_dragging) {
        pos = 0.0;
        _scrollController.jumpTo(0.0);
      } else {
        pos = _scrollController.position.pixels;
        if (pos > 0) return;
        if (primaryDelta < 0) return;
        _dragging = true;
      }
    }

    if (_dragging) {
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    }

    animationCurve = Curves.linear;

    final progress = primaryDelta / (_childHeight ?? primaryDelta);

    if (hasReachedWillPopThreshold) {
      _close();
      return;
    }

    widget.animationController.value -= progress;
  }

  void _handleDragEnd(double velocity) async {
    final enableDrag = widget.canDrag();
    if (!enableDrag) {
      return;
    }

    animationCurve = BottomSheetSuspendedCurve(
      widget.animationController.value,
      curve: _defaultCurve,
    );

    if (!_dragging) {
      return;
    }

    _dragging = false;

    // If speed is bigger than _minFlingVelocity try to close it
    if (velocity > _minFlingVelocity) {
      log("Velocity > minVel. so close");
      _close();
      return;
    }

    if (hasReachedCloseThreshold) {
      log("Rached position. so close");

      _close();
      return;
    }

    _cancelClose();
  }

  Curve get _defaultCurve => widget.animationCurve ?? _modalBottomSheetCurve;

  @override
  Widget build(BuildContext context) {
    var child = widget.child;
    if (widget.containerBuilder != null) {
      child = widget.containerBuilder!(
        context,
        widget.animationController,
        child,
      );
    }

    final mediaQuery = MediaQuery.of(context);

    child = AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, Widget? child) {
        assert(child != null);
        final animationValue = animationCurve.transform(mediaQuery.accessibleNavigation ? 1.0 : widget.animationController.value);

        return ClipRect(
          child: CustomSingleChildLayout(
            delegate: _ModalBottomSheetLayout(
              animationValue,
              widget.expanded,
            ),
            child: KeyedSubtree(
              key: _childKey,
              child: Listener(
                onPointerMove: (event) => _handleDragUpdate(event.delta.dy),
                onPointerUp: (event) => _handleDragEnd(0),
                child: child!,
              ),
            ),
          ),
        );
      },
      child: RepaintBoundary(child: child),
    );

    return ScrollToTopStatusBarHandler(
      child: child,
      scrollController: _scrollController,
    );
  }
}

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  _ModalBottomSheetLayout(this.progress, this.expand);

  final double progress;
  final bool expand;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: expand ? constraints.maxHeight : 0,
      maxHeight: expand ? constraints.maxHeight : constraints.minHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

// Checks the device input type as per the OS installed in it
// Mobile platforms will be default to `touch` while desktop will do to `mouse`
// Used with VelocityTracker2
// https://github.com/flutter/flutter/pull/64267#issuecomment-694196304
PointerDeviceKind defaultPointerDeviceKind(BuildContext context) {
  final platform = Theme.of(context).platform; // ?? defaultTargetPlatform;
  switch (platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.android:
      return PointerDeviceKind.touch;
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return PointerDeviceKind.mouse;
    case TargetPlatform.fuchsia:
      return PointerDeviceKind.unknown;
  }
}
