import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:all_sensors2/all_sensors2.dart';

enum AccelerometerRotationPosition {
  portrait,
  landscape,
  landscapeInverse,
}

mixin AccelerometerMixin<T extends StatefulHookConsumerWidget> on State<T> {
  StreamSubscription? _subscription;
  AccelerometerRotationPosition _current = AccelerometerRotationPosition.portrait;

  @override
  void initState() {
    super.initState();
    _subscription = accelerometerEvents?.listen(_onChange);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  _onChange(AccelerometerEvent event) {
    double x = event.x;
    double fix = math.sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
    x = event.x / fix;

    double xInclination = -(math.asin(x) * (180 / math.pi));

    AccelerometerRotationPosition? newRot;
    int delta = 25;

    if (xInclination < -(90 - delta) && xInclination > -(90 + delta)) {
      newRot = AccelerometerRotationPosition.landscape;
    }

    if (xInclination > (90 - delta) && xInclination < (90 + delta)) {
      newRot = AccelerometerRotationPosition.landscapeInverse;
    }

    if (xInclination > (0 - delta) && xInclination < (0 + delta)) {
      newRot = AccelerometerRotationPosition.portrait;
    }

    if (newRot != null && newRot != _current) {
      _current = newRot;
      onAccelerometerRotationChange(_current);
    }
  }

  onAccelerometerRotationChange(AccelerometerRotationPosition newRotation) {}
}
