import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/checklist/available_option/available_option.dart';
import 'package:truvideo_enterprise/model/checklist/extra_note/extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/item/item.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_extra_note/reply_extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_item_values/reply_item_values.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/error.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/color_option.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/extra_notes/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/field_title.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/index.dart';

class CheckListColorSelectorFormField extends FormField<Reply?> {
  CheckListColorSelectorFormField({
    Key? key,
    required Item item,
    required List<Reply> replies,
    required FormFieldSetter<Reply> onSaved,
    FormFieldValidator<Reply>? validator,
    Reply? initialValue,
    bool completed = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<Reply?> state) {
            final currentReply = state.value;
            final options = item.availableOptions;
            final selectedOption = item.findOptionByUID(state.value?.optionGroupUID ?? "");
            var extraNotes = <ExtraNote>[];
            if (selectedOption != null) {
              extraNotes = selectedOption.extraNotes;
            }

            void _onOptionPressed(AvailableOption value) {
              /// if completed is true, no state or value is changed, this widget becomes "read only"
              if (completed) return;

              // If reply already exists,
              // user is deselecting
              Reply? newReply;
              if (selectedOption?.uid == value.uid) {
                newReply = null;
              } else {
                // Else reply is changed as new
                newReply = Reply(
                  itemUID: item.uid,
                  replyItemValues: [
                    ReplyItemValues(
                      optionGroupUID: value.uid,
                      optionUID: value.uid,
                    ),
                  ],
                  replyExtraNote: [],
                );
              }
              state.didChange(newReply);
              onSaved(newReply);
            }

            void _saveTextNote(ExtraNote extraNote, ReplyExtraNote? newReplyExtraNote) {
              if (completed) return;

              final newReply = saveExtraNote(
                reply: currentReply,
                extraNote: extraNote,
                replyExtraNote: newReplyExtraNote,
              );

              state.didChange(newReply);
              onSaved(newReply);
            }

            // Label field input name
            String inputName = item.skippable ? item.inputName : "${item.inputName} *";

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChecklistFieldTitleWidget(title: inputName),
                const SizedBox(height: 8.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: options.map((option) {
                          final selected = selectedOption?.uid == option.uid;
                          final color = _getColor(option);

                          return ChecklistColorOptionWidget(
                            selected: selected,
                            anySelected: selectedOption != null,
                            onPressed: completed ? null : () => _onOptionPressed(option),
                            color: color,
                            width: constraints.maxWidth / options.length,
                            text: option.getColorName(item.inputType),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                // Extra notes
                CustomAnimatedCollapseVisibility(
                  visible: selectedOption != null && extraNotes.isNotEmpty,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: CheckListExtraNotes(
                      completed: completed, // if completed is true, no state or value is changed, this widget becomes "read only"
                      extraNotes: extraNotes,
                      replyExtraNotes: state.value?.replyExtraNote ?? [],
                      onSaved: _saveTextNote,
                    ),
                  ),
                ),
                CustomAnimatedCollapseVisibility(
                  visible: state.hasError,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                    child: CustomTextFieldError(
                      margin: EdgeInsets.zero,
                      message: state.errorText ?? "",
                    ),
                  ),
                ),
              ],
            );
          },
        );
}

Color _getColor(AvailableOption value) {
  Color result = Colors.grey;
  switch (value.color) {
    case "RED":
      result = CustomColorsUtils.checklistRed;
      break;
    case "GREEN":
      result = CustomColorsUtils.checklistGreen;
      break;
    case "YELLOW":
      result = CustomColorsUtils.checklistYellow;
      break;
    case "GREY":
      result = CustomColorsUtils.checklistGrey;
      break;
    default:
  }
  return result;
}
