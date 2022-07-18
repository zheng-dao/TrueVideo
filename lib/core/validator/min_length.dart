import 'package:form_field_validator/form_field_validator.dart';

class CustomMinLengthValidator extends TextFieldValidator {
  final int min;
  final bool required;

  CustomMinLengthValidator(
    this.min, {
    this.required = true,
    required String errorText,
  }) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    if (!required && (value == null || value.trim().isEmpty)) return true;
    return value!.length >= min;
  }
}
