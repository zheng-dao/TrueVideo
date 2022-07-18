import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/keypad/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';

class ScreenChecklistNotes extends StatefulWidget {
  final String initialValue;
  final String title;
  final Function(String value)? onChanged;
  final bool skippable;
  final bool multiline;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final String hintText;
  final bool useKeyPad;

  const ScreenChecklistNotes({
    Key? key,
    this.initialValue = "",
    this.onChanged,
    this.title = "",
    this.skippable = false,
    this.multiline = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.hintText = "",
    this.useKeyPad = false,
  }) : super(key: key);

  @override
  State<ScreenChecklistNotes> createState() => _ScreenChecklistNotesState();
}

class _ScreenChecklistNotesState extends State<ScreenChecklistNotes> {
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.initialValue;
    _controller.addListener(() {
      widget.onChanged?.call(_controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _close() {
    Navigator.of(context).pop();
  }

  Widget _wrapper({required BuildContext context, required Widget child}) {
    if (widget.useKeyPad) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: child,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBarColor = Theme.of(context).scaffoldBackgroundColor;
    final appBarIconColor = appBarColor.contrast(context);
    return CustomScaffold(
      resizeToAvoidBottomInset: !widget.useKeyPad,
      appbar: CustomAppBar(
        backgroundColor: appBarColor,
        titleColor: appBarIconColor,
        actionButtons: [
          CustomButtonIcon(
            icon: Icons.clear,
            elevation: 0,
            focusedElevation: 0,
            iconColor: appBarIconColor,
            onPressed: _close,
          ),
        ],
      ),
      body: _wrapper(
        context: context,
        child: Column(
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32.0),
            CustomTextField(
              hintText: widget.hintText,
              minLines: widget.multiline ? 3 : 1,
              maxLines: widget.multiline ? null : 1,
              controller: _controller,
              autofocus: true,
              readOnly: widget.useKeyPad,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              validator: (newValue) {
                if (newValue!.isEmpty && !widget.skippable) return "This field is required";
                return null;
              },
            ),
            if (widget.useKeyPad)
              Expanded(
                child: CustomKeypad(
                  margin: EdgeInsets.only(top: 32, bottom: MediaQuery.of(context).padding.bottom),
                  extraButton2Color: Colors.transparent,
                  extraButton2Visible: true,
                  extraButton2Builder: (c, size) => Icon(
                    Icons.backspace_outlined,
                    size: size * 0.3,
                  ),
                  onNumberPressed: (number) {
                    final text = "${_controller.text}$number";
                    _controller.value = TextEditingValue(
                      text: text,
                      selection: TextSelection.collapsed(offset: text.length),
                    );
                  },
                  onExtraButton2Pressed: () {
                    if (_controller.text.isEmpty) return;
                    final text = _controller.text.substring(0, _controller.text.length - 1);
                    _controller.value = TextEditingValue(
                      text: text,
                      selection: TextSelection.collapsed(offset: text.length),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
