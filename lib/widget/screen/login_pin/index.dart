import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/font.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/core/string.dart';
import 'package:truvideo_enterprise/hook/is_biometric_login_configured.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/biometric_login/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/keypad/index.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_loading.dart';
import 'package:truvideo_enterprise/widget/common/pin/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/snackbar/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_list/index.dart';
import 'package:truvideo_enterprise/widget/screen/splash/index.dart';

enum ScreenMode {
  none,
  withoutPin,
  loading,
  waitingApproval,
}

class ScreenLoginUserPinParams {
  final String userUuid;
  final String displayName;
  final String pin;
  CustomRouteType? routeType;

  ScreenLoginUserPinParams({
    required this.userUuid,
    required this.displayName,
    this.pin = "",
    this.routeType,
  });
}

class ScreenLoginUserPin extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenLoginUserPin";

  final ScreenLoginUserPinParams params;

  const ScreenLoginUserPin({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  ConsumerState<ScreenLoginUserPin> createState() => _ScreenLoginUserPinState();
}

class _ScreenLoginUserPinState extends ConsumerState<ScreenLoginUserPin> {
  final _pinFocusNode = FocusNode();
  final _pinTextController = TextEditingController();
  final int _pinLength = 6;
  ScreenMode _mode = ScreenMode.none;

  AuthService get _authService => GetIt.I.get();

  BiometricLoginService get _biometricLoginService => GetIt.I.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    _pinFocusNode.dispose();
    _pinTextController.dispose();
    super.dispose();
  }

  _init() {
    CustomKeyboardUtils.hide();

    final dealerCode = _authService.getStoredDealerCode();
    if (dealerCode.trim().isEmpty) {
      _goToSplash();
      return;
    }

    if (widget.params.pin.trim().isNotEmpty) {
      setState(() => _mode = ScreenMode.loading);
      _process(widget.params.pin);
      return;
    }

    setState(() => _mode = ScreenMode.withoutPin);

    final withBiometricLogin = _biometricLoginService.getStatus(widget.params.userUuid);
    if (withBiometricLogin) {
      _onBiometricPressed();
    } else {
      _pinFocusNode.requestFocus();
    }
  }

  _goToSplash() {
    Navigator.of(context).pushReplacementNamed(ScreenSplash.routeName);
  }

  _goToUserList() {
    Navigator.of(context).pushReplacementNamed(ScreenLoginUserList.routeName);
  }

  _process(String pin, {bool silent = false}) async {
    CustomKeyboardUtils.hide();

    final dealerCode = _authService.getStoredDealerCode();
    if (dealerCode.trim().isEmpty) {
      _goToSplash();
      return;
    }

    try {
      if (!silent) {
        setState(() => _mode = ScreenMode.loading);
      }

      final result = await _authService.login(
        dealerCode: dealerCode,
        userUuid: widget.params.userUuid,
        pin: pin,
      );
      if (!mounted) return;

      switch (result) {
        case LoginResult.success:
          _onLogin(
            userUUID: widget.params.userUuid,
            dealerCode: dealerCode,
            pin: pin,
          );
          break;

        case LoginResult.invalidPin:
          await showCustomDialogRetry(message: "Invalid pin code", retryButtonText: "Accept", cancelButtonVisible: false);
          setState(() => _mode = ScreenMode.withoutPin);
          _pinTextController.clear();
          _pinFocusNode.requestFocus();
          break;

        case LoginResult.unauthorized:
          setState(() => _mode = ScreenMode.waitingApproval);
          await Future.delayed(const Duration(seconds: 5));
          if (!mounted) return;
          _process(pin, silent: true);
          break;

        case LoginResult.userNotFound:
          await showCustomDialogRetry(message: "User not found", retryButtonText: "Accept", cancelButtonVisible: false);
          _goToUserList();
          break;

        case LoginResult.unknownError:
          final retry = await showCustomDialogRetry(message: "Unknown error");
          if (retry) {
            _process(pin, silent: silent);
            return;
          }

          setState(() => _mode = ScreenMode.withoutPin);
          _pinTextController.clear();
          _pinFocusNode.requestFocus();
          break;
      }
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);
      if (!mounted) return;

      bool retry;
      if (error is CustomException) {
        retry = await showCustomDialogRetry(message: error.message ?? "");
      } else {
        retry = await showCustomDialogRetry();
      }

      if (retry) {
        _process(pin);
      } else {
        setState(() => _mode = ScreenMode.withoutPin);
        _pinTextController.clear();
        _pinFocusNode.requestFocus();
      }
    }
  }

  Future<void> _askLinkBiometricPin({
    required String userUUID,
    required String dealerCode,
    required String pin,
  }) async {
    final shouldAsk = _biometricLoginService.shouldAskLink(userUUID);
    if (!shouldAsk) return;

    await showCustomDialog(
      title: "Biometric login",
      message: "Do you want to access with biometric data?",
      builder: (context, controller) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          CustomGradientButton(
            gradient: CustomColorsUtils.gradient,
            width: double.infinity,
            text: "Yes",
            onPressed: () async {
              try {
                controller.setLoading(true);
                await _biometricLoginService.store(
                  userUUID: userUUID,
                  dealerCode: dealerCode,
                  pin: pin,
                );

                showCustomSnackBarSuccess(title: "Biometric login configured correctly");
                controller.close();
              } catch (error, stack) {
                log("Error", error: error, stackTrace: stack);
                controller.setLoading(false);

                showCustomDialogRetry(
                  error: error,
                  cancelButtonVisible: false,
                  retryButtonText: "Accept",
                );
              }
            },
          ),
          const SizedBox(height: 8.0),
          CustomBorderButton.small(
            width: double.infinity,
            text: "No",
            onPressed: controller.close,
          ),
          const SizedBox(height: 8.0),
          CustomBorderButton.small(
            width: double.infinity,
            text: "Never ask again",
            onPressed: () {
              _biometricLoginService.markNeverAskAgainLink(userUUID);
              controller.close();
            },
          ),
        ],
      ),
    );
  }

  _onLogin({
    required String userUUID,
    required String dealerCode,
    required String pin,
  }) async {
    await _askLinkBiometricPin(
      userUUID: userUUID,
      dealerCode: dealerCode,
      pin: pin,
    );
    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed(ScreenSplash.routeName);
  }

  _close() {
    if (_loading) return;
    Navigator.of(context).pop();
  }

  bool get _loading => _mode == ScreenMode.loading;

  _onBiometricPressed() async {
    try {
      final pin = await _biometricLoginService.read(widget.params.userUuid);
      _process(pin);
    } catch (error) {
      log("Error reading pin", error: error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userBiometric = useIsBiometricLoginConfigured(
      ref,
      userUUID: widget.params.userUuid,
    );

    final theme = Theme.of(context);
    final backgroundColor = _mode == ScreenMode.waitingApproval ? theme.colorScheme.secondary : theme.scaffoldBackgroundColor;
    final isRouteTypeCupertinoVertical = widget.params.routeType == CustomRouteType.cupertinoVertical;
    final waitingForApproval = _mode == ScreenMode.waitingApproval;
    final buttonCloseIconColor = waitingForApproval ? theme.colorScheme.secondary.contrast(context) : null;
    final buttonClose = CustomButtonIcon(
      enabled: !_loading,
      icon: isRouteTypeCupertinoVertical ? Icons.clear : Icons.arrow_back_ios,
      backgroundColor: Colors.transparent,
      iconColor: buttonCloseIconColor,
      onPressed: _close,
    );

    return CustomScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appbar: CustomAppBar(
        backgroundColor: Colors.transparent,
        brightness: isRouteTypeCupertinoVertical ? Brightness.dark : Brightness.light,
        leading: isRouteTypeCupertinoVertical ? null : buttonClose,
        actionButtons: [
          CustomAnimatedFadeVisibility(
            visible: userBiometric && _mode == ScreenMode.withoutPin,
            child: CustomBorderButton.small(
              text: "Biometric access",
              onPressed: _onBiometricPressed,
            ),
          ),
          if (isRouteTypeCupertinoVertical) buttonClose,
        ],
      ),
      body: CustomAnimatedSwitcher(
        child: Builder(
          key: ValueKey(_mode),
          builder: (context) {
            switch (_mode) {
              case ScreenMode.none:
                return Container();
              case ScreenMode.withoutPin:
                return Column(
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      "Hello there ${CustomStringUtils.toTitleCase(widget.params.displayName)}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: CustomFontUtils.loginTitleSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      const TextSpan(children: [
                        TextSpan(
                          text: "Please type your ",
                        ),
                        TextSpan(text: "Personal Pin Code", style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: " to login")
                      ]),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    CustomPin(
                      autoFocus: false,
                      useNativeKeyboard: false,
                      controller: _pinTextController,
                      focusNode: _pinFocusNode,
                      length: _pinLength,
                      onChange: (value) {
                        if (value.length == _pinLength) {
                          _process(value);
                        }
                      },
                      enabled: !_loading,
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: CustomKeypad(
                        extraButton2Color: Colors.transparent,
                        extraButton2Visible: true,
                        extraButton2Builder: (c, size) => Icon(Icons.backspace_outlined, size: size * 0.3),
                        onExtraButton2Pressed: () {
                          if (_pinTextController.text.isEmpty) return;
                          _pinTextController.text = _pinTextController.text.substring(0, _pinTextController.text.length - 1);
                        },
                        onNumberPressed: (number) {
                          if (_pinTextController.text.length >= 6) return;
                          _pinTextController.text = "${_pinTextController.text}$number";
                        },
                      ),
                    ),
                    SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
                  ],
                );
              case ScreenMode.loading:
                return const Center(child: CustomListIndicatorLoading());
              case ScreenMode.waitingApproval:
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 128,
                          height: 128,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary.contrast(context),
                          ),
                          child: Icon(
                            MdiIcons.accountCheckOutline,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 52,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          "Almost done!",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.secondary.contrast(context)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Your user creation is under review. We will let you know as soon is approved.",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary.contrast(context)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
