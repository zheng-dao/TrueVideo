
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/checklist/available_option/available_option.dart';
import 'package:truvideo_enterprise/model/checklist/extra_note/extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/item/item.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_extra_note/reply_extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_item_values/reply_item_values.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/ripple/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/error.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/color_option.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/extra_notes/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/field_title.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/index.dart';

class CheckListColorMeasureFormField extends FormField<Reply?> {
  CheckListColorMeasureFormField({
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
            final selectedColor = item.findOptionByUID(state.value?.optionGroupUID ?? "");
            final selectedNumber =
                selectedColor?.availableOptions.firstWhereOrNull((e) => e.uid == currentReply?.replyItemValues?.firstOrNull?.optionUID);

            var subOptions = <AvailableOption>[];
            var extraNotes = <ExtraNote>[];
            if (selectedColor != null) {
              extraNotes = selectedColor.extraNotes;
              subOptions = selectedColor.availableOptions;
            }

            void _onOptionPressed(AvailableOption value) {
              /// if completed is true, no state or value is changed, this widget becomes "read only"
              if (completed) return;
              // If reply already exists,
              // user is deselecting
              Reply? newReply;
              if (selectedColor?.uid == value.uid) {
                newReply = null;
              } else {
                // Else reply is changed as new
                newReply = Reply(
                  itemUID: item.uid,
                  replyItemValues: [
                    ReplyItemValues(
                      optionGroupUID: value.uid,
                    ),
                  ],
                );
              }
              state.didChange(newReply);
              onSaved(newReply);
            }

            // Render Color selector Row
            Widget _buildColorSelector() {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    children: [
                      ...options
                          .map(
                            (e) => ChecklistColorOptionWidget(
                              anySelected: selectedColor != null,
                              selected: selectedColor?.uid == e.uid,
                              onPressed: completed ? null : () => _onOptionPressed(e),
                              color: _getColor(e),
                              width: constraints.maxWidth / options.length,
                            ),
                          )
                          .toList(),
                    ],
                  );
                },
              );
            }

            // Render Value selector Row
            Widget _renderValueSelector() {
              // if No color is selected nothing is rendered
              // if (state.value!.isEmpty) return Container();

              void _onPressed(AvailableOption value) {
                if (completed) return;

                Reply? newReply;
                if (state.value!.optionUID == value.uid) {
                  // if Option Selected is same in reply,
                  // then user is deselecting

                  newReply = state.value?.copyWith(
                    replyItemValues: [
                      ReplyItemValues(
                        optionGroupUID: selectedColor?.uid ?? "",
                        optionUID: "",
                      ),
                    ],
                  );
                } else {
                  // if Option Selected is not the same in reply,
                  // then user is selecting
                  newReply = state.value?.copyWith(
                    replyItemValues: [
                      ReplyItemValues(
                        optionGroupUID: selectedColor?.uid ?? "",
                        optionUID: value.uid,
                      ),
                    ],
                  );
                }

                state.didChange(newReply);
                onSaved(newReply);
              }

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  key: ValueKey(selectedColor?.uid),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        children: [
                          ...subOptions.map(
                            (e) {
                              final index = subOptions.indexWhere((i) => e.uid == i.uid);
                              final anySelected = (state.value?.optionUID ?? "").trim().isNotEmpty;
                              final selected = e.uid == state.value?.optionUID;

                              var borderColor = Colors.transparent;
                              var fillColor = Colors.transparent;
                              if (selectedColor != null) {
                                if (anySelected) {
                                  borderColor = selected ? Colors.black : CustomColorsUtils.divider;
                                  fillColor = selected ? _getColor(selectedColor) : Colors.transparent;
                                } else {
                                  borderColor = _getColor(selectedColor);
                                }
                              }

                              final w = (constraints.maxWidth - ((subOptions.length - 1) * 4)) / subOptions.length;

                              return Container(
                                margin: EdgeInsets.only(left: index != 0 ? 4.0 : 0.0),
                                child: CustomRipple(
                                  onPressed: completed ? null : () => _onPressed(e),
                                  color: fillColor,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: 50,
                                    width: w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2.0,
                                        color: borderColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        e.getColorName(e.type),
                                        style: TextStyle(
                                          color: selected ? fillColor.contrast(context) : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ],
                      );
                    },
                  ),
                ),
              );
            }

            // Label field input name

            String inputName = item.skippable ? item.inputName : "${item.inputName} *";

            void _saveExtraNote(ExtraNote extraNote, ReplyExtraNote? newReplyExtraNote) {
              if (completed) return;

              final newReply = saveExtraNote(
                reply: currentReply,
                extraNote: extraNote,
                replyExtraNote: newReplyExtraNote,
              );

              state.didChange(newReply);
              onSaved(newReply);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChecklistFieldTitleWidget(title: inputName),
                const SizedBox(height: 8.0),

                // Color selector
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildColorSelector(),
                ),

                // Values selector
                CustomAnimatedCollapseVisibility(
                  visible: selectedColor != null && subOptions.isNotEmpty,
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 8.0),
                    child: _renderValueSelector(),
                  ),
                ),

                // Description
                Builder(
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                      width: double.maxFinite,
                      child: Center(
                        child: Text(
                          item.inputDescription,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    );
                  },
                ),

                // Extra notes
                CustomAnimatedCollapseVisibility(
                  visible: selectedColor != null && selectedNumber != null && extraNotes.isNotEmpty,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: CheckListExtraNotes(
                      completed: completed,
                      extraNotes: extraNotes,
                      replyExtraNotes: state.value?.replyExtraNote ?? [],
                      onSaved: _saveExtraNote,
                    ),
                  ),
                ),

                // Error
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

Color getTextColor(AvailableOption value, bool selected) {
  Color result = Colors.grey;
  switch (value.color) {
    case "RED":
      result = selected ? CustomColorsUtils.backgroundColor : CustomColorsUtils.checklistRed;
      break;
    case "GREEN":
      result = selected ? CustomColorsUtils.backgroundColor : CustomColorsUtils.checklistGreen;
      break;
    case "YELLOW":
      result = selected ? CustomColorsUtils.backgroundColor : CustomColorsUtils.checklistYellow;
      break;
    case "GREY":
      result = selected ? CustomColorsUtils.backgroundColor : CustomColorsUtils.checklistGrey;
      break;
    default:
  }
  return result;
}

Color getValueColor(AvailableOption value) {
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
