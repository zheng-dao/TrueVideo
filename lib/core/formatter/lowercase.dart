import 'package:flutter/services.dart';

class CustomTextInputFormatterLowercase extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      composing: newValue.composing,
      selection: newValue.selection,
      text: newValue.text.toLowerCase(),
    );
  }
}
