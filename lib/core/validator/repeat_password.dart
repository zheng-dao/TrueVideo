import 'package:form_field_validator/form_field_validator.dart';

class RepeatPasswordValidator extends TextFieldValidator {
  final String password;

  RepeatPasswordValidator({
    required String errorText,
    required this.password,
  }) : super(errorText);

  @override
  bool isValid(String? value) {
    if (value == null) return true;
    return value == password;
  }
}
