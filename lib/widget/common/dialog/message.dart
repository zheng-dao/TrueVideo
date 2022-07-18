import 'package:flutter/material.dart';

class CustomDialogMessage extends StatelessWidget {
  final String text;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const CustomDialogMessage({
    Key? key,
    this.text = "",
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.start,
      ),
    );
  }
}
