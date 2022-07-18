import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply.dart';
import 'package:truvideo_enterprise/model/checklist/section/section.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';

class ChecklistSectionTile extends HookConsumerWidget {
  final Section section;
  final bool arrowVisible;
  final List<Reply> replies;
  final Function()? onPressed;

  const ChecklistSectionTile({
    Key? key,
    this.replies = const [],
    required this.section,
    this.arrowVisible = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isComplete = useMemoized(() => section.isSectionComplete(replies), [section, replies]);

    return CustomListTile(
      onPressed: onPressed,
      leadingPadding: EdgeInsets.zero,
      leading: CustomAnimatedCollapseVisibility(
        axis: Axis.horizontal,
        visible: isComplete,
        child: Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: CustomListTileImage(
            icon: Icons.check_circle_outline_outlined,
            iconColor: CustomColorsUtils.checklistGreen,
            color: Colors.transparent,
          ),
        ),
      ),
      titleText: section.title,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            // filled data from current replies / required items length in section
            "${section.getFilledDataLength(replies)}/${section.items.length}",
            style: TextStyle(color: CustomColorsUtils.textFieldBorder),
          ),
          if (arrowVisible)
            const CustomListTileImage(
              color: Colors.transparent,
              icon: Icons.keyboard_arrow_right,
            ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}
