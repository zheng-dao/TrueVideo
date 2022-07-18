import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/checklist/extra_note/extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_extra_note/reply_extra_note.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/extra_notes/text/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/extra_notes/header.dart';

import 'check/index.dart';

class CheckListExtraNotes extends StatefulWidget {
  final List<ExtraNote> extraNotes;
  final List<ReplyExtraNote>? replyExtraNotes;
  final Function(ExtraNote extraNote, ReplyExtraNote? reply)? onSaved;
  final bool completed;

  const CheckListExtraNotes({
    required this.extraNotes,
    required this.replyExtraNotes,
    this.onSaved,
    this.completed = true,
    Key? key,
  }) : super(key: key);

  @override
  State<CheckListExtraNotes> createState() => _CheckListExtraNotesState();
}

class _CheckListExtraNotesState extends State<CheckListExtraNotes> {
  bool _isExpanded = false;

  Widget _buildTextExtraNote(ExtraNote extraNote) {
    final reply = widget.replyExtraNotes?.firstWhereOrNull((element) => element.optionUID == extraNote.uid);

    return CheckListExtraNotesTextField(
      extraNote: extraNote,
      initialValue: reply,
      completed: widget.completed,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      onSaved: (newReply) => widget.onSaved?.call(extraNote, newReply),
    );
  }

  Widget _buildCheckbox(ExtraNote extraNote) {
    final reply = widget.replyExtraNotes?.firstWhereOrNull((element) => element.optionUID == extraNote.uid);

    return CheckboxTileFormField(
      onSaved: (newReply) => widget.onSaved?.call(extraNote, newReply),
      initialValue: reply,
      completed: widget.completed,
      extraNote: extraNote,
    );
  }

  Widget _buildExtraNote(ExtraNote extraNote) {
    if (extraNote.className == 'with-text') {
      return _buildTextExtraNote(extraNote);
    }

    return _buildCheckbox(extraNote);
  }

  bool get enabled {
    return widget.extraNotes.isNotEmpty;
  }

  bool get containsData {
    if (!enabled) return false;

    final replyExtraNotes = widget.replyExtraNotes;
    if (replyExtraNotes == null) {
      return false;
    }

    bool result = false;

    for (var note in widget.extraNotes) {
      final reply = (widget.replyExtraNotes ?? []).firstWhereOrNull((e) => e.optionUID == note.uid);
      if (reply != null) {
        if (note.className == "with-text") {
          if ((reply.description?.trim() ?? "").isNotEmpty) {
            result = true;
            break;
          }
        } else {
          result = true;
          break;
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChecklistExtraNotesHeader(
          enabled: enabled,
          expanded: _isExpanded,
          finished: containsData,
          onPressed: () {
            setState(() {
              setState(() => _isExpanded = !_isExpanded);
            });
          },
        ),
        CustomAnimatedCollapseVisibility(
          visible: _isExpanded && enabled,
          child: CustomList<ExtraNote>.separated(
            scrollPhysics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            data: widget.extraNotes,
            itemBuilder: (context, item) => _buildExtraNote(item),
            separatorBuilder: (context) => Container(height: 8.0),
            areItemsTheSame: (a, b) => a.uid == b.uid,
          ),
        ),
      ],
    );
  }
}
