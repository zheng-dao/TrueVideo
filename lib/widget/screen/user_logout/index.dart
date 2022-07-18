import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_twilio/flutter_twilio.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/riverpod/auth.dart';
import 'package:truvideo_enterprise/riverpod/fcm_token.dart';
import 'package:truvideo_enterprise/riverpod/messaging_authentication_information.dart';
import 'package:truvideo_enterprise/riverpod/user_settings.dart';
import 'package:truvideo_enterprise/riverpod/voip_call_status.dart';
import 'package:truvideo_enterprise/riverpod/voip_call_token.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/screen/login/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_list/index.dart';

class ScreenUserLogout extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenUserLogout";

  const ScreenUserLogout({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenUserLogout> createState() => _ScreenUserLogoutState();
}

class _ScreenUserLogoutState extends ConsumerState<ScreenUserLogout> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  _init() async {
    final AuthService authService = GetIt.I.get();

    try {
      await authService.logout();
    } catch (error, stack) {
      log("Error log out", error: error, stackTrace: stack);
    }

    try {
      FlutterTwilio.unregister();
    } catch (error, stack) {
      log("Error unregistering", error: error, stackTrace: stack);
    }

    if (!mounted) return;

    ref.read(voipCallStatusPod.notifier).state = VoipCallStatus.nothing;
    ref.read(fcmTokenPod.notifier).state = "";
    ref.read(messagingAuthenticationInformationPod.notifier).state = null;
    ref.read(voipCallTokenPod.notifier).state = null;
    ref.read(authPod.notifier).state = null;
    ref.read(userSettingsPod.notifier).state = [];

    final AuthService service = GetIt.I.get();
    final dealerCode = service.getStoredDealerCode();
    if (dealerCode.trim().isNotEmpty) {
      Navigator.of(context).pushReplacementNamed(ScreenLoginUserList.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(ScreenLogin.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onWillPop: () async => false,
      resizeToAvoidBottomInset: false,
      appbar: const CustomAppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: CustomColorsUtils.gradient,
        ),
        child: Center(
          child: SizedBox(
            width: 150,
            child: Image.asset(
              "assets/images/logo-white.png",
            ),
          ),
        ),
      ),
    );
  }
}
