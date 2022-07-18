import 'package:flutter/material.dart';

class CustomGestureDetector extends StatefulWidget {
  final Widget? child;
  final Function(Offset initialPosition)? onDragStart;
  final Function(Offset position)? onDragUpdate;
  final Function(Offset position)? onDragCancel;
  final Function(Offset position)? onDragEnd;
  final bool Function()? canDrag;
  final bool enabled;
  final Function()? onTap;

  const CustomGestureDetector({
    Key? key,
    this.onDragUpdate,
    this.child,
    this.onDragStart,
    this.onDragCancel,
    this.onDragEnd,
    this.canDrag,
    this.enabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomGestureDetector> createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {
  int _pointerCount = 0;
  late Offset _delta;
  late Offset _firstLocation;
  bool _dragging = false;

  bool get _canDrag {
    return _dragging && (widget.canDrag?.call() ?? true);
  }

  _onPointerDown(PointerDownEvent event) {
    _pointerCount++;
    _firstLocation = event.position;

    if (_pointerCount == 1) {
      widget.onDragStart?.call(event.localPosition);
      _dragging = true;
      _delta = Offset.zero;
    } else {
      _dragging = false;
      widget.onDragCancel?.call(event.localPosition);
    }
  }

  _onPointerCancel(PointerCancelEvent event) {
    _pointerCount--;

    if (!_canDrag) return;
    if (_pointerCount != 0) return;
    widget.onDragCancel?.call(event.localPosition);
  }

  _onPointerMove(PointerMoveEvent event) {
    if (!_canDrag) return;
    widget.onDragUpdate?.call(_delta + event.localDelta);
  }

  _onPointerUp(PointerUpEvent event) {
    _pointerCount--;

    if (_pointerCount == 0) {
      final dif = (_firstLocation - event.localPosition);
      if (dif.dx.abs() < 50 && dif.dy.abs() < 50) {
        widget.onTap?.call();
      }
    }

    if (!_canDrag) return;
    if (_pointerCount != 0) return;
    widget.onDragEnd?.call(event.localPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: widget.enabled ? _onPointerDown : null,
      onPointerUp: widget.enabled ? _onPointerUp : null,
      onPointerCancel: widget.enabled ? _onPointerCancel : null,
      onPointerMove: widget.enabled ? _onPointerMove : null,
      child: widget.child,
    );
  }
}
