import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';

class CustomPin extends StatelessWidget {
  final int length;
  final Function(String value)? callback;
  final bool enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autoFocus;
  final Function(String value)? onChange;
  final double width;
  final double height;
  final bool useNativeKeyboard;

  const CustomPin({
    Key? key,
    this.width = 50,
    this.height = 50,
    this.autoFocus = true,
    this.focusNode,
    this.controller,
    required this.length,
    this.callback,
    this.enabled = true,
    this.onChange,
    this.useNativeKeyboard = true,
  }) : super(key: key);

  PinTheme _decoration(BuildContext context) => PinTheme(
        height: height,
        width: width,
        textStyle: const TextStyle(fontSize: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Theme.of(context).inputDecorationTheme.border?.borderSide.color ?? Colors.transparent,
            width: 1,
          ),
        ),
      );

  PinTheme _focusDecoration(BuildContext context) => PinTheme(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedFadeVisibility(
      visible: enabled,
      minOpacity: 0.5,
      child: Pinput(
        controller: controller,
        focusNode: focusNode,
        defaultPinTheme: _decoration(context),
        focusedPinTheme: _focusDecoration(context),
        disabledPinTheme: _decoration(context),
        errorPinTheme: _decoration(context),
        followingPinTheme: _decoration(context),
        submittedPinTheme: _decoration(context),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        closeKeyboardWhenCompleted: true,
        separator: Container(width: 8.0),
        enabled: enabled,
        length: length,
        onCompleted: callback,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        onChanged: (value) => onChange?.call(value),
        autofocus: autoFocus,
        useNativeKeyboard: useNativeKeyboard,
        showCursor: false,
        keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }
}
