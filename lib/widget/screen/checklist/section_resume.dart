import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply.dart';
import 'package:truvideo_enterprise/model/checklist/section/section.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_translation/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/section_tile.dart';

class CheckListSectionResume extends StatelessWidget {
  final List<Section> sections;
  final List<Reply> replies;
  final bool visible;
  final Function(Section section)? onSectionPressed;

  const CheckListSectionResume({
    Key? key,
    required this.sections,
    this.visible = false,
    this.replies = const [],
    this.onSectionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return CustomAnimatedTranslation(
      translation: visible ? Offset.zero : Offset(0.0, -MediaQuery.of(context).size.height),
      child: CustomAnimatedFadeVisibility(
        visible: visible,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: CustomFadingEdgeList(
            child: CustomList<Section>.separated(
              padding: EdgeInsets.only(
                top: 16,
                bottom: mq.padding.bottom + 16.0,
              ),
              data: sections,
              areItemsTheSame: (a, b) => a.uid == b.uid,
              itemBuilder: (context, item) => ChecklistSectionTile(
                section: item,
                replies: replies,
                onPressed: () => onSectionPressed?.call(item),
                arrowVisible: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
