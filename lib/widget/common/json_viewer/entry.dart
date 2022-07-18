import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';

import 'index.dart';

class CustomJsonViewerEntry extends StatefulWidget {
  final String title;
  final dynamic value;
  final int count;

  final EdgeInsets? padding;

  const CustomJsonViewerEntry({
    Key? key,
    this.title = "",
    this.value,
    this.count = 0,
    this.padding,
  }) : super(key: key);

  @override
  State<CustomJsonViewerEntry> createState() => _CustomJsonViewerEntryState();
}

class _CustomJsonViewerEntryState extends State<CustomJsonViewerEntry> {
  bool _expanded = false;

  String _trailingText(dynamic value) {
    if (value is Map) return "Json Object";
    if (value is List) return "List";
    if (value == null) return "";
    return value.runtimeType.toString();
  }

  String _subtitleText(dynamic value) {
    if (value is Map || value is List) return _expanded ? "Tap to collapse" : "Tap to expand";
    return value.toString();
  }

  Widget? _buildValue(dynamic value) {
    if (value is Map) {
      return CustomJsonViewer(
        json: value,
        count: widget.count + 1,
      );
    }

    if (value is List) {
      return CustomList<Object>.separated(
        data: value.map((e) => e as Object).toList(),
        shrinkWrap: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, item) {
          if (item is Map) {
            final index = value.indexOf(item);
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: (widget.count + 2) * 16, top: 4.0, bottom: 4.0),
                  child: Text("Item ${index + 1}"),
                ),
                CustomJsonViewer(
                  json: item,
                  count: widget.count + 2,
                ),
              ],
            );
          }

          return CustomListTile(
            contentPadding: EdgeInsets.only(left: (widget.count + 2) * 16),
            dense: true,
            titleText: item.toString(),
          );
        },
        areItemsTheSame: (a, b) => a == b,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final valueWidget = _buildValue(widget.value);

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomListTile(
            contentPadding: EdgeInsets.only(
              left: (widget.count + 1) * 16.0,
              right: 16.0,
              top: 8,
              bottom: 8,
            ),
            titleText: widget.title,
            subtitleText: _subtitleText(widget.value),
            subtitleMaxLines: null,
            trailingText: _trailingText(widget.value),
            dense: true,
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
          if (valueWidget != null)
            Container(
              color: Colors.black.withOpacity(0.05),
              child: CustomAnimatedCollapseVisibility(
                visible: _expanded,
                child: valueWidget,
              ),
            ),
        ],
      ),
    );
  }
}
