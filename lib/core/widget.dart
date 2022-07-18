import 'dart:async';

import 'package:flutter/scheduler.dart';

class CustomWidgetUtils {
  static Future<void> wait({int duration = 0}) {
    var completer = Completer();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: duration));
      completer.complete();
    });

    return completer.future;
  }
}
