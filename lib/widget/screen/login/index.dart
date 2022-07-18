import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/font.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/model/dealer_code_access_history.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:timeago/timeago.dart' as time_ago;

import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/container/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/keypad/index.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/pin/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/mixin/back_button_exit.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_list/index.dart';

class ScreenLogin extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenLogin";

  const ScreenLogin({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends ConsumerState<ScreenLogin> with BackButtonExitMixin {
  int _devClicksCount = 0;
  final int _devMaxCount = 7;
  Timer? _devTimer;

  final _pinController = TextEditingController();
  final _pinFocusNode = FocusNode();
  final int _pinLength = 6;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final AuthService service = GetIt.I.get();
    service.clearDealerCode();
  }

  @override
  void dispose() {
    _pinFocusNode.dispose();
    _pinController.dispose();
    super.dispose();
  }

  _onLogoPressed() {
    if (_devClicksCount >= _devMaxCount) return;

    setState(() => _devClicksCount += 1);
    _devTimer?.cancel();

    if (_devClicksCount < _devMaxCount) {
      _devTimer = Timer(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        setState(() => _devClicksCount = 0);
      });
    }
  }

  _searchDealer(String dealerCode) async {
    CustomKeyboardUtils.hide();

    if (dealerCode.isEmpty) return;

    final AuthService service = GetIt.I.get();
    await service.clearDealerCode();

    try {
      setState(() => _loading = true);
      final dealer = await service.getDealerInfo(dealerCode);
      if (!mounted) return;

      if (dealer == null) {
        throw CustomException(message: "Dealer not found", code: 404);
      }

      await service.storeDealerCode(dealerCode);

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(ScreenLoginUserList.routeName);
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);
      if (!mounted) return;
      setState(() => _loading = false);

      _defaultException() async {
        final retry = await showCustomDialogRetry(message: "$error");
        if (retry) {
          _searchDealer(dealerCode);
        } else {
          _pinFocusNode.requestFocus();
          _pinController.clear();
        }
      }

      if (error is CustomException) {
        switch (error.code) {
          case 404:
            {
              await showCustomDialogRetry(
                title: "Error",
                message: "Dealer not found",
                retryButtonText: "Accept",
                cancelButtonVisible: false,
              );
              _pinFocusNode.requestFocus();
              _pinController.clear();
            }
            break;

          default:
            {
              _defaultException();
            }
            break;
        }
      } else {
        _defaultException();
      }
    }
  }

  _onRecentDealerCodesPressed() async {
    final AuthService authService = GetIt.I.get();
    final dealerCodes = await authService.getDealerCodesHistory();

    showCustomDialog(
      title: "Recent dealer codes",
      childPadding: EdgeInsets.zero,
      builder: (context, controller) => CustomList<DealerCodeAccessHistoryModel>.separated(
        areItemsTheSame: (a, b) => a.dealerCode == b.dealerCode,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        data: dealerCodes,
        itemBuilder: (context, item) => CustomListTile(
          titleText: item.dealerCode,
          trailingText: item.date != null ? time_ago.format(item.date!) : "",
          onPressed: () async {
            await controller.close();
            _searchDealer(item.dealerCode);
          },
        ),
      ),
      buttonsBuilder: (context, controller) => [
        CustomGradientButton.small(
          gradient: CustomColorsUtils.gradient,
          text: "Accept",
          onPressed: () {
            controller.close();
          },
        )
      ],
    );
  }

  Future<bool> _onWillPop() async {
    if (_loading) return false;
    return onButtonBackPressed();
  }

  @override
  Widget build(BuildContext context) {
    final debug = _devClicksCount == _devMaxCount;
    final recentDealerCodesVisible = debug;

    return CustomScaffold(
      onWillPop: _onWillPop,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appbar: const CustomAppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      body: CustomContainer(
        alignment: Alignment.topCenter,
        mode: _loading ? CustomContainerMode.loading : CustomContainerMode.normal,
        builder: (c) => Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: MediaQuery.of(context).padding.top,
            bottom: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Hello there",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: CustomFontUtils.loginTitleSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.center,
                child: Text.rich(
                  const TextSpan(children: [
                    TextSpan(
                      text: "Please type your ",
                    ),
                    TextSpan(text: "Dealer Code", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: " to identify you")
                  ]),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              const SizedBox(height: 32),
              CustomPin(
                length: _pinLength,
                callback: _searchDealer,
                enabled: !_loading,
                focusNode: _pinFocusNode,
                controller: _pinController,
                useNativeKeyboard: false,
              ),
              CustomAnimatedCollapseVisibility(
                visible: recentDealerCodesVisible,
                child: CustomBorderButton.small(
                  enabled: !_loading,
                  margin: const EdgeInsets.only(top: 16.0),
                  text: "Recent dealer codes",
                  onPressed: () => _onRecentDealerCodesPressed(),
                ),
              ),
              Expanded(
                child: CustomKeypad(
                  extraButton2Visible: true,
                  extraButton2Color: Colors.transparent,
                  extraButton2Builder: (context, size) => Icon(
                    Icons.backspace_outlined,
                    size: size * 0.3,
                  ),
                  onExtraButton2Pressed: () {
                    if (_pinController.text.isEmpty) return;
                    _pinController.text = _pinController.text.substring(0, _pinController.length - 1);
                  },
                  onNumberPressed: (int number) {
                    if (_pinController.text.length >= 6) return;
                    _pinController.text = "${_pinController.text}$number";
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      navigationBar: Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 27,
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () => _onLogoPressed(),
            child: SizedBox(
              width: 114,
              child: Image.asset("assets/images/logo-color.png"),
            ),
          ),
        ),
      ),
    );
  }
}
