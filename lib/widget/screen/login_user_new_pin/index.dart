import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/core/string.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_text_switcher/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/keypad/index.dart';
import 'package:truvideo_enterprise/widget/common/pin/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_new/model/result.dart';

class ScreenLoginUserNewPinParams {
  final String name;
  final String lastName;
  final String title;
  final String email;
  final String username;
  final String password;
  final String dealerUuid;
  final String dealerCode;
  final String phoneNumber;
  CustomRouteType? routeType;

  ScreenLoginUserNewPinParams({
    required this.name,
    required this.lastName,
    required this.title,
    required this.email,
    required this.username,
    required this.password,
    required this.dealerUuid,
    required this.dealerCode,
    this.phoneNumber = "",
    this.routeType,
  });
}

class ScreenLoginUserNewPin extends StatefulWidget {
  static const String routeName = "/ScreenLoginUserNewPin";

  final ScreenLoginUserNewPinParams params;

  const ScreenLoginUserNewPin({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  State<ScreenLoginUserNewPin> createState() => _ScreenLoginUserNewPinState();
}

class _ScreenLoginUserNewPinState extends State<ScreenLoginUserNewPin> {
  final _pinController = TextEditingController();
  final _pinFocusNode = FocusNode();
  final int _pinLength = 6;
  bool _loading = false;
  String _pin = "";

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  _process(String pin) {
    if (int.tryParse(pin) == null) {
      return;
    }

    _pinController.clear();
    _pinFocusNode.requestFocus();
    setState(() => _pin = pin);
  }

  _validate(String pin) async {
    if (_pin != pin) {
      await showCustomDialogRetry(
        message: "The pin codes do not match",
        retryButtonText: "Accept",
      );
      _pinController.clear();
      _pinFocusNode.requestFocus();
      return;
    }

    CustomKeyboardUtils.hide();
    try {
      setState(() => _loading = true);
      final AuthService service = GetIt.I.get();
      final user = await service.create(
        dealerCode: widget.params.dealerCode,
        firstName: widget.params.name,
        lastName: widget.params.lastName,
        title: widget.params.title,
        email: widget.params.email,
        username: widget.params.username,
        password: widget.params.password,
        pin: pin,
        publicDealerUuid: widget.params.dealerUuid,
        integrationId: "",
        mobileNumber: widget.params.phoneNumber,
      );
      if (!mounted) return;

      Navigator.of(context).pop(CreateUserResult(
        displayName: CustomStringUtils.toTitleCase("${widget.params.name} ${widget.params.lastName}"),
        uuid: user.publicUserUuid,
        pin: pin,
      ));
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);
      if (!mounted) return;

      setState(() => _loading = false);

      final retry = await showCustomDialogRetry(message: "$error");
      if (retry) {
        _validate(pin);
      }
    }
  }

  _close() {
    if (_loading) return;
    if (_pin.trim().isNotEmpty) {
      _pinController.clear();
      _pinFocusNode.requestFocus();
      setState(() {
        _pin = "";
      });
      return;
    }

    Navigator.of(context).pop();
  }

  Future<bool> _onWillPop() async {
    _close();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final isRouteTypeCupertinoVertical = widget.params.routeType == CustomRouteType.cupertinoVertical;
    final buttonClose = CustomButtonIcon(
      enabled: !_loading,
      icon: isRouteTypeCupertinoVertical ? Icons.clear : Icons.arrow_back_ios,
      iconColor: Colors.white.contrast(context),
      backgroundColor: Colors.transparent,
      onPressed: _close,
    );

    return CustomScaffold(
      onWillPop: !_loading ? null : _onWillPop,
      appbar: CustomAppBar(
        brightness: isRouteTypeCupertinoVertical ? Brightness.dark : Brightness.light,
        backgroundColor: Colors.transparent,
        leading: isRouteTypeCupertinoVertical ? null : buttonClose,
        actionButtons: isRouteTypeCupertinoVertical ? [buttonClose] : [],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32.0),
            CustomAnimatedTextSwitcher(
              text: _pin.trim().isNotEmpty ? "Confirm your pin" : "Create your pin",
              textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),
              textAlign: TextAlign.center,
            ),
            CustomAnimatedTextSwitcher(
              text: _pin.trim().isNotEmpty ? "Enter again your pin in order to confirm it" : "Please type your personal pin code to login",
              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomPin(
              controller: _pinController,
              focusNode: _pinFocusNode,
              length: _pinLength,
              callback: _pin.trim().isEmpty ? _process : _validate,
              enabled: !_loading,
              useNativeKeyboard: false,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: CustomKeypad(
                extraButton2Visible: true,
                extraButton2Color: Colors.transparent,
                extraButton2Builder: (c, size) => Icon(
                  Icons.backspace_outlined,
                  size: size * 0.3,
                ),
                onNumberPressed: (number) {
                  if (_pinController.text.length >= 6) return;
                  _pinController.text = "${_pinController.text}$number";
                },
                onExtraButton2Pressed: () {
                  if (_pinController.text.isEmpty) return;
                  _pinController.text = _pinController.text.substring(0, _pinController.text.length - 1);
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
