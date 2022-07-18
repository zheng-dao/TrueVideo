import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/checklist/extra_note/extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_extra_note/reply_extra_note.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';

class CheckboxTileFormField extends FormField<ReplyExtraNote?> {
  CheckboxTileFormField({
    Key? key,
    required ExtraNote extraNote,
    ReplyExtraNote? initialValue,
    required FormFieldSetter<ReplyExtraNote?> onSaved,
    FormFieldValidator<ReplyExtraNote?>? validator,
    bool completed = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<ReplyExtraNote?> state) {
            final currentReply = state.value;

            _onPressed() {
              ReplyExtraNote? newReply;
              if (currentReply == null) {
                newReply = ReplyExtraNote(
                  optionUID: extraNote.uid,
                  description: null,
                );
              } else {
                newReply = null;
              }
              state.didChange(newReply);
              onSaved(newReply);
            }

            return CustomListTile(
              dense: true,
              enabled: !completed,
              onPressed: _onPressed,
              titleText: extraNote.getDisplayName,
              subtitleText: extraNote.getDisplayName,
              trailing: Checkbox(
                value: currentReply != null,
                onChanged: (bool? newValue) => _onPressed(),
                activeColor: CustomColorsUtils.callBackground,
              ),
            );
          },
        );
}
