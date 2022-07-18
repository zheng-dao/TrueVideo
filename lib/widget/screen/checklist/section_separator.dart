import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply.dart';
import 'package:truvideo_enterprise/model/checklist/section/section.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_rotation/index.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'dart:math' as math;

class ChecklistSectionSeparator extends StatelessWidget {
  final Section section;
  final List<Reply> replies;
  final Function(Section section)? onPressed;
  final bool expanded;

  const ChecklistSectionSeparator({
    required this.section,
    required this.replies,
    Key? key,
    this.onPressed,
    this.expanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      dense: true,
      color: Theme.of(context).dividerColor,
      leadingPadding: EdgeInsets.zero,
      leading: CustomAnimatedCollapseVisibility(
        axis: Axis.horizontal,
        visible: section.isSectionComplete(replies),
        child: Container(
          margin: const EdgeInsets.only(right: 8.0),
          child: CustomListTileImage(
            icon: Icons.check_circle_outline_outlined,
            iconColor: CustomColorsUtils.checklistGreen,
            color: Colors.transparent,
          ),
        ),
      ),
      titleText: section.title,
      trailing: Row(
        children: [
          Text('${section.getFilledDataLength(replies)}/${section.items.length}'),
          const SizedBox(width: 8.0),
          CustomAnimatedRotation(
            rotation: expanded ? math.pi : 0.0,
            child: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
            ),
          ),
        ],
      ),
      onPressed: onPressed == null ? null : () => onPressed?.call(section),
    );
  }
}
