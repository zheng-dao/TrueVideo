import 'package:flutter/material.dart';

class ChecklistFieldTitleWidget extends StatelessWidget {
  final String title;

  const ChecklistFieldTitleWidget({Key? key, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(title),
    );
  }
}
