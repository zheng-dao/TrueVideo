import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';

class CustomMessageComposer extends StatefulWidget {
  final TextEditingController? controller;
  final bool enabled;
  final bool autoFocus;
  final String hintText;
  final Function(String text)? onButtonSendPressed;
  final EdgeInsets? margin;
  final bool buttonsEnabled;
  final bool loading;

  const CustomMessageComposer({
    Key? key,
    this.controller,
    this.enabled = true,
    this.autoFocus = false,
    this.hintText = "Send a new message...",
    this.onButtonSendPressed,
    this.margin,
    this.buttonsEnabled = true,
    this.loading = false,
  }) : super(key: key);

  @override
  State<CustomMessageComposer> createState() => _CustomMessageComposerState();
}

class _CustomMessageComposerState extends State<CustomMessageComposer> {
  late TextEditingController _controller;
  // final _cameraVisible = ValueNotifier(false);

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(textListener);
    textListener();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.removeListener(textListener);
    } else {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomMessageComposer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller != null) {
        oldWidget.controller!.removeListener(textListener);
      } else {
        _controller.dispose();
      }

      if (widget.controller != null) {
        _controller = widget.controller!;
      } else {
        _controller = TextEditingController();
      }
      _controller.addListener(textListener);
      textListener();
    }
  }

  textListener() {
    // _cameraVisible.value = _controller.text.trim().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      margin: widget.margin,
      enabled: widget.enabled,
      controller: _controller,
      autofocus: widget.autoFocus,
      hintText: widget.hintText,
      textInputAction: TextInputAction.send,
      onSubmitted: widget.onButtonSendPressed,
      contentPadding: const EdgeInsets.only(
        left: 20.0,
        top: 8.0,
        bottom: 8.0,
        right: 8.0,
      ),
      suffixBuilder: (context, value) => Row(
        children: [
          // Dummy view for maintain height
          Container(height: 40.0),

          // // Attach button
          // ValueListenableBuilder(
          //   valueListenable: _cameraVisible,
          //   builder: (context, value, child) => CustomAnimatedCollapseVisibility(
          //     axis: Axis.horizontal,
          //     visible: _cameraVisible.value,
          //     child: child,
          //   ),
          //   child: CustomIconButton(
          //     enabled: widget.buttonsEnabled,
          //     tooltip: "Send an image",
          //     icon: Icons.image_outlined,
          //     backgroundColor: Colors.transparent,
          //     elevation: 0,
          //     focusedElevation: 0,
          //     iconColor: Theme.of(context).colorScheme.background.contrast(context),
          //     onPressed: widget.onButtonSendPressed == null ? null : () => widget.onButtonSendPressed?.call(value),
          //   ),
          // ),
          // Send button
          CustomButtonIcon(
            loading: widget.loading,
            enabled: widget.buttonsEnabled,
            tooltip: "Send message",
            icon: Icons.send,
            backgroundColor: Colors.transparent,
            elevation: 0,
            focusedElevation: 0,
            iconColor: Theme.of(context).colorScheme.secondary,
            onPressed: widget.onButtonSendPressed == null ? null : () => widget.onButtonSendPressed?.call(value),
          ),
        ],
      ),
    );
  }
}
