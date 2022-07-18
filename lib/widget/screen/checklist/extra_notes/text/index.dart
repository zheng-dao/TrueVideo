import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/model/checklist/extra_note/extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_extra_note/reply_extra_note.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/screen_notes/index.dart';

class CheckListExtraNotesTextField extends FormField<ReplyExtraNote?> {
  CheckListExtraNotesTextField({
    Key? key,
    required ExtraNote extraNote,
    ReplyExtraNote? initialValue,
    FormFieldSetter<ReplyExtraNote?>? onSaved,
    FormFieldValidator<ReplyExtraNote?>? validator,
    bool completed = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    EdgeInsets? margin,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          validator: validator,
          builder: (FormFieldState<ReplyExtraNote?> state) {
            final currentReply = state.value;

            _onChange(String value) {
              ReplyExtraNote? newReply;
              if (value.trim().isEmpty) {
                newReply = null;
              } else {
                newReply = ReplyExtraNote(
                  optionUID: extraNote.uid,
                  description: value,
                );
              }

              state.didChange(newReply);
              onSaved?.call(newReply);
            }

            _onPressed(BuildContext context, String initialValue) {
              Navigator.of(context).push(
                customCupertinoModalBottomSheetRoute(
                  child: ScreenChecklistNotes(
                    title: extraNote.getDisplayName,
                    onChanged: _onChange,
                    skippable: true,
                    initialValue: initialValue,
                    multiline: true,
                    hintText: extraNote.getDescription,
                  ),
                ),
              );
            }

            return HookBuilder(
              builder: (context) {
                final controller = useTextEditingController();

                useEffect(
                  () {
                    controller.text = currentReply?.description ?? "";
                    return () {};
                  },
                  [currentReply],
                );
                return Container(
                  margin: margin,
                  child: CustomTextField(
                    enabled: !completed,
                    onPressed: () => _onPressed(context, controller.text),
                    minLines: 3,
                    maxLines: 4,
                    labelText: extraNote.getDisplayName,
                    hintText: extraNote.getDescription,
                    controller: controller,
                  ),
                );
              },
            );
          },
        );
}
