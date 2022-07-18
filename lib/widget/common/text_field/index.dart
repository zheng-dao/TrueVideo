import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/ripple/index.dart';

import 'counter.dart';
import 'error.dart';

class CustomTextField extends StatefulHookConsumerWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enabled;
  final TextInputType? keyboardType;
  final bool readOnly;
  final int? maxLength;
  final int minLines;
  final int? maxLines;
  final bool showCursor;
  final TextAlign textAlign;
  final bool autocorrect;
  final String hintText;
  final String labelText;
  final EdgeInsets? margin;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final Widget Function(BuildContext context, String value)? suffixBuilder;
  final EdgeInsets? contentPadding;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? backgroundColor;
  final FormFieldValidator<String>? validator;
  final bool showMaxLengthCounter;
  final Function(String value)? onSaved;
  final Function(String value)? onSubmitted;
  final Function()? onEditingComplete;
  final Widget? helperWidget;
  final double? borderRadius;
  final double? borderWidth;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Function(String value)? onChanged;
  final Key? formFieldKey;
  final Color? hintTextColor;
  final Color? cursorColor;
  final Function()? onPressed;
  final Widget Function(String error)? errorBuilder;

  const CustomTextField({
    Key? key,
    this.errorBuilder,
    this.onPressed,
    this.cursorColor,
    this.hintTextColor,
    this.formFieldKey,
    this.suffixBuilder,
    this.onChanged,
    this.textInputAction,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.onEditingComplete,
    this.onSubmitted,
    this.borderRadius,
    this.onSaved,
    this.showMaxLengthCounter = true,
    this.validator,
    this.backgroundColor,
    this.contentPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.enabled = true,
    this.keyboardType,
    this.readOnly = false,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.showCursor = true,
    this.textAlign = TextAlign.start,
    this.autocorrect = false,
    this.hintText = "",
    this.labelText = "",
    this.margin,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    this.borderColor,
    this.focusedBorderColor,
    this.helperWidget,
    this.borderWidth,
  }) : super(key: key);

  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  final _error = ValueNotifier<String>("");
  final _text = ValueNotifier<String>("");
  final _focused = ValueNotifier(false);

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);

    _controller = widget.controller ?? TextEditingController(text: "");
    _controller.addListener(_textControllerListener);

    _text.value = _controller.text;
    _text.addListener(() {
      if (!mounted) return;
      _validate();
    });

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }

    _controller.removeListener(_textControllerListener);
    if (widget.controller == null) {
      _controller.dispose();
    }

    super.dispose();
  }

  String? _validate() {
    if (!mounted) return null;

    if (widget.validator == null) {
      _error.value = "";
      return null;
    }

    final error = widget.validator!(_controller.text);
    _error.value = error ?? "";
    return error;
  }

  _onFocusChange() {
    if (!mounted) return;

    final newFocus = _focusNode.hasFocus;
    if (newFocus != _focused.value) {
      _focused.value = newFocus;
    }
  }

  _textControllerListener() {
    if (!mounted) return;

    if (_controller.text != _text.value) {
      var text = _controller.text;
      if (widget.maxLength != null && text.length > widget.maxLength!) {
        text = text.substring(0, widget.maxLength);
        _controller.text = text;
        _controller.selection = TextSelection.collapsed(offset: widget.maxLength!);
      }
      _text.value = text;
    }
  }

  EdgeInsets get _contentPadding {
    return widget.contentPadding ?? const EdgeInsets.all(15.0);
  }

  Widget _pressedWrapper({required Widget child}) {
    if (widget.onPressed == null) return child;

    return CustomRipple(
      onPressed: widget.onPressed,
      child: IgnorePointer(
        ignoring: true,
        child: Container(
          color: Colors.transparent,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = widget.backgroundColor ?? theme.inputDecorationTheme.fillColor ?? Colors.transparent;
    final borderColor = widget.borderColor ?? theme.inputDecorationTheme.border?.borderSide.color ?? Colors.transparent;
    final focusedBorderColor = widget.focusedBorderColor ?? theme.inputDecorationTheme.focusedBorder?.borderSide.color ?? Colors.transparent;
    final accentColor = theme.colorScheme.secondary;

    bool withBorder = true;
    if (widget.borderWidth != null) {
      withBorder = widget.borderWidth! > 0;
    } else {
      withBorder = (theme.inputDecorationTheme.border?.borderSide.width ?? 0.0) > 0;
    }
    BorderRadius? currentBorderRadius;
    if (widget.borderRadius != null) {
      currentBorderRadius = BorderRadius.circular(widget.borderRadius!);
    } else {
      if (theme.inputDecorationTheme.border != null && theme.inputDecorationTheme.border is OutlineInputBorder) {
        currentBorderRadius = (theme.inputDecorationTheme.border as OutlineInputBorder).borderRadius;
      }
    }

    final withLabelText = widget.labelText.trim().isNotEmpty;
    final showMaxLengthCounter = widget.maxLength != null && widget.showMaxLengthCounter;

    return Container(
      margin: widget.margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (withLabelText || showMaxLengthCounter)
            Container(
              margin: const EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
              child: Row(
                children: [
                  if (withLabelText) Expanded(child: Text(widget.labelText)),
                  if (!withLabelText) const Spacer(),
                  if (showMaxLengthCounter)
                    MultiValueListenableBuilder(
                      valueListenables: [_focused, _text],
                      builder: (context, values, child) => CustomAnimatedFadeVisibility(
                        visible: _focused.value,
                        child: CustomTextFieldCounter(
                          count: _text.value.length,
                          limit: widget.maxLength!,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          CustomAnimatedFadeVisibility(
            visible: widget.enabled,
            minOpacity: 0.5,
            child: ValueListenableBuilder(
              valueListenable: _focused,
              builder: (context, value, child) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  border: withBorder ? Border.all(color: _focused.value ? focusedBorderColor : borderColor) : null,
                  borderRadius: currentBorderRadius,
                ),
                clipBehavior: Clip.hardEdge,
                child: child,
              ),
              child: _pressedWrapper(
                child: Row(
                  children: [
                    if (widget.prefix != null)
                      Container(
                        padding: EdgeInsets.only(
                          left: _contentPadding.left,
                          top: _contentPadding.top,
                          bottom: _contentPadding.bottom,
                        ),
                        child: IconTheme(
                          data: IconThemeData(
                            size: 20,
                            color: backgroundColor.contrast(context),
                          ),
                          child: widget.prefix!,
                        ),
                      ),
                    Expanded(
                      child: FormField(
                        key: widget.formFieldKey,
                        validator: (val) => _validate(),
                        onSaved: widget.onSaved != null ? (newValue) => widget.onSaved?.call(_controller.text) : null,
                        enabled: widget.enabled,
                        initialValue: "",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        builder: (field) => TextField(
                          enabled: widget.enabled,
                          onChanged: widget.onChanged != null ? (value) => widget.onChanged?.call(value) : null,
                          textInputAction: widget.textInputAction,
                          textCapitalization: widget.textCapitalization,
                          obscureText: widget.obscureText,
                          autofocus: widget.autofocus,
                          focusNode: _focusNode,
                          controller: _controller,
                          cursorColor: widget.cursorColor ?? accentColor,
                          readOnly: widget.readOnly,
                          minLines: widget.minLines,
                          maxLines: widget.maxLines,
                          showCursor: widget.showCursor,
                          textAlign: widget.textAlign,
                          autocorrect: widget.autocorrect,
                          keyboardType: widget.keyboardType,
                          onEditingComplete: widget.onEditingComplete != null ? () => widget.onEditingComplete?.call() : null,
                          onSubmitted: widget.onSubmitted != null ? (value) => widget.onSubmitted?.call(value) : null,
                          inputFormatters: widget.inputFormatters,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            hintText: widget.hintText,
                            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: widget.hintTextColor),
                            contentPadding: widget.contentPadding ?? const EdgeInsets.all(15.0),
                            isDense: true,
                            border: const OutlineInputBorder(borderSide: BorderSide.none),
                            disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                            errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                            focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    if (widget.suffix != null || widget.suffixBuilder != null)
                      Container(
                        padding: EdgeInsets.only(
                          right: _contentPadding.right,
                          top: _contentPadding.top,
                          bottom: _contentPadding.bottom,
                        ),
                        child: IconTheme(
                          data: IconThemeData(
                            size: 20,
                            color: backgroundColor.contrast(context),
                          ),
                          child: widget.suffix ??
                              ValueListenableBuilder<String>(
                                valueListenable: _text,
                                builder: (context, value, child) => widget.suffixBuilder?.call(context, value) ?? Container(),
                                child: Container(),
                              ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          ValueListenableBuilder<String>(
            valueListenable: _error,
            builder: (context, value, child) {
              if (widget.errorBuilder != null) {
                return widget.errorBuilder!.call(_error.value);
              }

              return CustomAnimatedCollapseVisibility(
                visible: _error.value.trim().isNotEmpty || widget.helperWidget != null,
                child: CustomTextFieldError(
                  message: _error.value,
                  child: widget.helperWidget,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
