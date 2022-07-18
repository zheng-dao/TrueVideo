import 'package:flutter/material.dart';

class CustomKeyboardUtils {
  static hide() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}
