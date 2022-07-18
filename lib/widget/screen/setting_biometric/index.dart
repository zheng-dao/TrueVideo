import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/hook/is_biometric_login_configured.dart';
import 'package:truvideo_enterprise/riverpod/auth.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/biometric_login/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/pin/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/snackbar/index.dart';

class ScreenSettingsBiometricParams {
  CustomRouteType? routeType;

  ScreenSettingsBiometricParams({this.routeType});
}

class ScreenSettingsBiometric extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenSettingBiometric";

  final ScreenSettingsBiometricParams params;

  const ScreenSettingsBiometric({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  ConsumerState<ScreenSettingsBiometric> createState() => _ScreenSettingBiometricState();
}

class _ScreenSettingBiometricState extends ConsumerState<ScreenSettingsBiometric> {
  bool _loading = false;

  AuthService get _authService => GetIt.I.get();

  BiometricLoginService get _biometricLoginService => GetIt.I.get();

  @override
  void dispose() {
    super.dispose();
  }

  _close() {
    Navigator.of(context).pop();
  }

  _save(String pin) async {
    try {
      setState(() => _loading = true);
      final user = ref.read(authPod);
      final dealerCode = _authService.getStoredDealerCode();
      await _biometricLoginService.store(
        pin: pin,
        dealerCode: dealerCode,
        userUUID: user?.publicUserUuid ?? "",
      );
      setState(() => _loading = false);
      showCustomSnackBarSuccess(title: "Biometric login configured correctly");
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);

      if (!mounted) return;

      final retry = await showCustomDialogRetry(error: error);
      if (retry) {
        _save(pin);
      } else {
        setState(() => _loading = false);
      }
    }
  }

  _askDelete() {
    showCustomDialog(
      title: "Delete",
      message: "Are you sure?",
      buttonsBuilder: (context, controller) => [
        CustomBorderButton.small(
          text: "Cancel",
          onPressed: controller.close,
        ),
        CustomBorderButton.small(
          text: "Delete",
          textColor: CustomColorsUtils.delete,
          borderColor: CustomColorsUtils.delete,
          onPressed: () {
            controller.close();
            _delete();
          },
        ),
      ],
    );
  }

  _delete() async {
    try {
      final user = ref.read(authPod);
      await _biometricLoginService.delete(user?.publicUserUuid ?? "");
    } catch (error) {
      log("Error deleting biometric info");
    }
  }

  Widget _buildChild({required bool stored}) {
    Widget child;
    if (stored) {
      child = _buildStored();
    } else {
      child = _buildNotStored();
    }

    return CustomAnimatedSwitcher(
      alignment: Alignment.topCenter,
      child: child,
    );
  }

  Widget _buildNotStored() {
    return Column(
      key: const ValueKey("not-stored"),
      children: [
        const SizedBox(height: 32),
        Text(
          "Insert your pin",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 32),
        CustomPin(
          length: 6,
          enabled: !_loading,
          callback: _save,
          autoFocus: false,
        ),
        const SizedBox(height: 16),
        CustomAnimatedFadeVisibility(
          visible: _loading,
          child: const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ],
    );
  }

  Widget _buildStored() {
    return Column(
      key: const ValueKey("stored"),
      children: [
        const SizedBox(height: 32),
        Icon(
          Icons.check_circle_outlined,
          color: Colors.green.shade600,
          size: 70,
        ),
        Text(
          "Biometric login",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Text("You have already configured the biometric login"),
        CustomBorderButton.small(
          margin: const EdgeInsets.only(top: 32),
          text: "Delete",
          icon: Icons.delete_outline,
          textColor: CustomColorsUtils.delete,
          borderColor: CustomColorsUtils.delete,
          onPressed: _askDelete,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRouteTypeCupertinoVertical = widget.params.routeType == CustomRouteType.cupertinoVertical;
    final appBarColor = Theme.of(context).scaffoldBackgroundColor;
    final appBarIconColor = appBarColor.contrast(context);
    final closeButton = CustomButtonIcon(
      icon: isRouteTypeCupertinoVertical ? Icons.clear : Icons.arrow_back_ios,
      backgroundColor: Colors.transparent,
      iconColor: appBarIconColor,
      onPressed: _close,
    );
    final stored = useIsBiometricLoginConfigured(ref);

    return CustomScaffold(
      appbar: CustomAppBar(
        backgroundColor: appBarColor,
        titleColor: appBarIconColor,
        leading: isRouteTypeCupertinoVertical ? null : closeButton,
        actionButtons: isRouteTypeCupertinoVertical ? [closeButton] : [],
      ),
      body: CustomFadingEdgeList(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ).copyWith(
            bottom: 16 + MediaQuery.of(context).padding.bottom,
          ),
          child: SizedBox(
            width: double.infinity,
            child: _buildChild(
              stored: stored,
            ),
          ),
        ),
      ),
    );
  }
}
