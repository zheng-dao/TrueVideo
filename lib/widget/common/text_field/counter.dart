import 'package:flutter/material.dart';

class CustomTextFieldCounter extends StatelessWidget {
  final int limit;
  final int count;

  const CustomTextFieldCounter({
    Key? key,
    this.limit = 0,
    this.count = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$count/$limit",
      style: Theme.of(context).textTheme.caption,
    );
  }
}
