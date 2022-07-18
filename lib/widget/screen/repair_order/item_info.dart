import 'package:flutter/material.dart';

class ScreenRepairOrderDetailItemInfo extends StatelessWidget {
  final String title;
  final String text;

  const ScreenRepairOrderDetailItemInfo({Key? key, this.title = "", this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.trim().isNotEmpty)
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        if (text.trim().isNotEmpty)
          SelectableText(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }
}
