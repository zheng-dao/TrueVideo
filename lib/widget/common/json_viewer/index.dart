import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';

import 'entry.dart';

class CustomJsonViewer extends StatelessWidget {
  final Map<dynamic, dynamic> json;
  final int count;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;

  const CustomJsonViewer({
    Key? key,
    this.json = const <dynamic, dynamic>{},
    this.count = 0,
    this.padding,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomList<MapEntry>.separated(
      shrinkWrap: true,
      padding: padding,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      data: json.entries.toList(),
      areItemsTheSame: (a, b) => a.key == b.key,
      itemBuilder: (context, item) => CustomJsonViewerEntry(
        title: item.key.toString(),
        value: jsonDecode(jsonEncode(item.value)),
        count: count,
        padding: contentPadding,
      ),
    );
  }
}
