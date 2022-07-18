import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';

class ChecklistExtraNotesHeader extends StatelessWidget {
  final bool finished;
  final bool enabled;
  final bool expanded;
  final Function()? onPressed;

  const ChecklistExtraNotesHeader({
    required this.finished,
    required this.enabled,
    Key? key,
    this.onPressed,
    required this.expanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      dense: true,
      enabled: enabled,
      title: Row(
        children: [
          CustomAnimatedCollapseVisibility(
            axis: Axis.horizontal,
            visible: finished,
            child: Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.check, color: Colors.green.shade600, size: 20),
            ),
          ),
          const Expanded(
            child: Text("Extra notes"),
          ),
        ],
      ),
      onPressed: onPressed,
      trailing: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: CustomListTileImage(
          key: ValueKey(expanded),
          icon: expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
