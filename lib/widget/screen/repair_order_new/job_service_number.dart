import 'package:async/async.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/error.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';

class CustomJobServiceNumberTextField extends StatefulWidget {
  final EdgeInsets? margin;
  final bool enabled;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool required;
  final Function(String value)? onSubmitted;

  const CustomJobServiceNumberTextField({
    Key? key,
    this.enabled = true,
    this.focusNode,
    this.controller,
    this.required = false,
    this.onSubmitted,
    this.margin,
  }) : super(key: key);

  @override
  State<CustomJobServiceNumberTextField> createState() => _CustomJobServiceNumberTextFieldState();
}

class _CustomJobServiceNumberTextFieldState extends State<CustomJobServiceNumberTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  bool _loading = false;
  String _error = "";
  CancelableOperation? _operation;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _operation?.cancel();

    if (widget.controller == null) {
      _controller.dispose();
    }

    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
  }

  _onChange(String value) {
    if (value.trim().isEmpty && widget.required) {
      _operation?.cancel();
      EasyDebounce.cancel("validateJobServiceNumber");
      setState(() {
        _loading = false;
        _error = "Required";
      });
      return;
    }

    setState(() {
      _loading = false;
      _error = "";
    });

    EasyDebounce.debounce(
      "validateJobServiceNumber",
      const Duration(milliseconds: 300),
      () => _validate(value),
    );
  }

  _validate(String value) async {
    _operation?.cancel();
    EasyDebounce.cancel("validateJobServiceNumber");

    try {
      if (value.trim().isEmpty) {
        setState(() {
          _loading = false;
          _error = "";
        });
        return;
      }

      setState(() {
        _loading = true;
        _error = "";
      });

      final RepairOrderService repairOrderService = GetIt.I.get();

      _operation = CancelableOperation.fromFuture(repairOrderService.validateJobServiceNumber(value));
      final valid = await _operation?.value;

      setState(() {
        _loading = false;
        _error = valid ? "" : "Duplicated number";
      });
    } catch (error) {
      _operation?.cancel();
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = "Unknown error";
      });
    }
  }

  Widget _buildJobServiceNumberStatus() {
    if (_loading) {
      return const SizedBox(
        width: 15,
        height: 15,
        child: Center(
          child: SizedBox(
            width: 10,
            height: 10,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
        ),
      );
    }

    return const SizedBox(
      width: 15,
      height: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        children: [
          CustomTextField(
            enabled: widget.enabled,
            focusNode: _focusNode,
            controller: _controller,
            labelText: "Repair Order #",
            keyboardType: TextInputType.text,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]'))],
            textInputAction: TextInputAction.next,
            onChanged: _onChange,
            maxLength: 40,
            errorBuilder: (error) => Container(),
            validator: (value) {
              if (_loading) return "loading";
              if (_error.trim().isNotEmpty) return "error";
              if (widget.required && (value ?? "").trim().isEmpty) {
                _error = "Required";
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {});
                });
                return "error";
              }
              return null;
            },
            onSubmitted: widget.onSubmitted,
            suffix: _buildJobServiceNumberStatus(),
          ),
          CustomAnimatedCollapseVisibility(
            visible: _error.trim().isNotEmpty,
            child: CustomTextFieldError(
              message: _error,
            ),
          ),
        ],
      ),
    );
  }
}
