import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/model/checklist/extra_note/extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/item/item.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_extra_note/reply_extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_item_values/reply_item_values.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/extra_notes/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/field_title.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/screen_notes/index.dart';

class CheckListMeasureField extends FormField<Reply?> {
  CheckListMeasureField({
    Key? key,
    required Item item,
    Reply? initialValue,
    required FormFieldSetter<Reply> onSaved,
    FormFieldValidator<Reply>? validator,
    bool completed = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          validator: validator,
          builder: (FormFieldState<Reply?> state) {
            final currentReply = state.value;
            final currentExtraNotes = item.extraNotes;
            final currentReplyExtraNotes = currentReply?.replyExtraNote ?? [];

            _onChanged(TextEditingController controller, String value) {
              controller.text = value;

              Reply? newReply;
              if (value.trim().isEmpty) {
                newReply = null;
              } else {
                newReply = Reply(
                  itemUID: item.uid,
                  replyItemValues: [
                    ReplyItemValues(
                      optionGroupUID: item.uid,
                      optionUID: item.uid,
                      value: value,
                    )
                  ],
                );
              }

              state.didChange(newReply);
              onSaved(newReply);
            }

            _onPressed(BuildContext context, TextEditingController controller) {
              Navigator.of(context).push(
                customCupertinoModalBottomSheetRoute(
                  child: ScreenChecklistNotes(
                    title: item.inputName,
                    onChanged: (value) => _onChanged(controller, value),
                    skippable: item.skippable,
                    initialValue: controller.text,
                    multiline: false,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    useKeyPad: true,
                  ),
                ),
              );
            }

            _saveExtraNote(ExtraNote extraNote, ReplyExtraNote? newReplyExtraNote) {
              if (completed) return;

              final newReply = saveExtraNote(
                reply: currentReply,
                extraNote: extraNote,
                replyExtraNote: newReplyExtraNote,
              );

              state.didChange(newReply);
              onSaved(newReply);
            }

            return HookBuilder(
              builder: (context) {
                final controller = useTextEditingController();
                useEffect(
                  () {
                    controller.text = currentReply?.getValue ?? "";
                    return () {};
                  },
                  [controller, currentReply],
                );

                return Column(
                  children: [
                    ChecklistFieldTitleWidget(title: item.inputName),
                    const SizedBox(height: 8),
                    CustomTextField(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      enabled: !completed,
                      onPressed: () => _onPressed(context, controller),
                      controller: controller,
                      validator: (newValue) {
                        if (newValue!.isEmpty && !item.skippable) return "This field is required";
                        return null;
                      },
                    ),
                    CustomAnimatedCollapseVisibility(
                      visible: currentReply != null && currentExtraNotes.isNotEmpty,
                      child: Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: CheckListExtraNotes(
                          completed: completed,
                          extraNotes: currentExtraNotes,
                          replyExtraNotes: currentReplyExtraNotes,
                          onSaved: _saveExtraNote,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
}
