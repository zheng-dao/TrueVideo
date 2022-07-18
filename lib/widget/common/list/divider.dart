import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  const CustomDivider({Key? key, this.margin, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      height: 1,
      width: double.infinity,
      color: Theme.of(context).dividerColor,
    );
  }
}
