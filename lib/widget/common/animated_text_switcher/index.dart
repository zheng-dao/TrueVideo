import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';

class CustomAnimatedTextSwitcher extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Alignment alignment;
  final TextAlign textAlign;

  const CustomAnimatedTextSwitcher({
    Key? key,
    this.text = "",
    this.textStyle,
    this.alignment = Alignment.center,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedSwitcher(
      alignment: alignment,
      child: Container(
        key: ValueKey("${text}_$textStyle"),
        child: Text(
          text,
          style: textStyle,
          textAlign: textAlign,
        ),
      ),
    );
  }
}
