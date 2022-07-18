import 'package:flutter/services.dart';
import 'package:truvideo_enterprise/core/string.dart';

class CustomTextInputFormatterCapitalized extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      composing: newValue.composing,
      selection: newValue.selection,
      text: CustomStringUtils.toCapitalized(newValue.text),
    );
  }
}
