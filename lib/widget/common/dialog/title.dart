import 'package:flutter/material.dart';

class CustomDialogTitle extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;

  const CustomDialogTitle({
    Key? key,
    this.text = "",
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
