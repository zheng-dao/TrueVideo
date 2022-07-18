import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_twilio/flutter_twilio.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/message_authentication_information.dart';
import 'package:truvideo_enterprise/model/user.dart';
import 'package:truvideo_enterprise/model/user_settings.dart';
import 'package:truvideo_enterprise/model/voip_call_token.dart';
import 'package:truvideo_enterprise/riverpod/auth.dart';
import 'package:truvideo_enterprise/riverpod/user_settings.dart';
import 'package:truvideo_enterprise/riverpod/voip_call_status.dart';
import 'package:truvideo_enterprise/riverpod/fcm_token.dart';
import 'package:truvideo_enterprise/riverpod/messaging_authentication_information.dart';
import 'package:truvideo_enterprise/riverpod/voip_call_token.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/push_notification/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/screen/home/index.dart';
import 'package:truvideo_enterprise/widget/screen/user_logout/index.dart';

class ScreenSplash extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenSplash";

  const ScreenSplash({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends ConsumerState<ScreenSplash> {
  bool _error = false;

  AuthService get _authService => GetIt.I.get();

  PushNotificationService get _pushNotificationService => GetIt.I.get();

  ConnectivityService get _connectivityService => GetIt.I.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    super.dispose();
  }

  _init() async {
    setState(() {
      _error = false;
    });

    // final VoipService voipService = GetIt.I.get();
    // final MessagingService messagingService = GetIt.I.get();

    await FlutterTwilio.setAndroidCallStyle(
      backgroundColor: CustomColorsUtils.callBackground.hex,
      textColor: "#FFFFFFFF",
      buttonColor: CustomColorsUtils.callParticipantColor.hex,
      buttonIconColor: "#FFFFFFFF",
      buttonFocusColor: "#FFFFFFFF",
      buttonFocusIconColor: "#FF000000",
    );

    try {
      UserModel? user;
      List<UserSettingsModel>? userSettings;
      MessageAuthenticationInformationModel? messageAuthenticationInformation;

      if (await _connectivityService.isOffline()) {
        user = await _authService.getCachedLoggedUser();
        if (user != null) {
          //messageAuthenticationInformation = await messagingService.getCachedAuthenticationInformation();
          userSettings = await _authService.getCachedUserSettings();
        }
      } else {
        user = await _authService.isLogin();
        if (user != null) {
          // messageAuthenticationInformation = await messagingService.authenticate();
          userSettings = await _authService.getUserSettings();
        }
      }
      if (!mounted) return;

      if (user == null) {
        _goToLogin();
        return;
      }

      if (userSettings == null) {
        throw CustomException(message: "User settings not found");
      }

      // if (messageAuthenticationInformation == null) {
      //   throw CustomException();
      // }

      await _pushNotificationService.requestPermission();
      // final micPermission = await Permission.microphone.request();
      // if (micPermission.isDenied) {
      //   throw CustomException(message: "Must grant mic permission");
      // }

      String fcmToken = "";
      VoipCallTokenModel? voipCallToken;
      VoipCallStatus callStatus = VoipCallStatus.nothing;

      // Only register the calls when the user is online
      if (await _connectivityService.isOnline()) {
        // voipCallToken = await voipService.register(
        //   uid: messageAuthenticationInformation.subjectMessageableEntity!.uid,
        //   accountUID: messageAuthenticationInformation.accountUID,
        // );
        //
        // if (voipCallToken == null) {
        //   throw CustomException();
        // }
        //
        fcmToken = await _pushNotificationService.getToken();
        // await FlutterTwilio.register(
        //   identity: voipCallToken.identity,
        //   accessToken: voipCallToken.token,
        //   fcmToken: fcmToken,
        // );
        //
        // callStatus = VoipCallStatus.ready;
      }

      if (!mounted) return;

      ref.read(voipCallStatusPod.notifier).state = callStatus;
      ref.read(fcmTokenPod.notifier).state = fcmToken;
      ref.read(messagingAuthenticationInformationPod.notifier).state = messageAuthenticationInformation;
      ref.read(voipCallTokenPod.notifier).state = voipCallToken;
      ref.read(authPod.notifier).state = user;
      ref.read(userSettingsPod.notifier).state = userSettings;
      _goToHome();
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);
      if (!mounted) return;

      setState(() {
        _error = true;
      });
    }
  }

  _goToLogin() async {
    Navigator.of(context).pushReplacementNamed(ScreenUserLogout.routeName);
  }

  _goToHome() {
    Navigator.of(context).pushReplacementNamed(ScreenHome.routeName);
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
        decoration: BoxDecoration(color: CustomColorsUtils.accent),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/logo-white.png",
                width: 114,
              ),
              CustomAnimatedCollapseVisibility(
                visible: _error,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  margin: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 50,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Something went wrong",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white),
                      ),
                      CustomBorderButton(
                        width: 200,
                        fillColor: Colors.white.withOpacity(0.2),
                        splashColor: Colors.white.withOpacity(0.4),
                        highlightColor: Colors.white.withOpacity(0.2),
                        margin: const EdgeInsets.only(top: 32.0),
                        text: "Retry",
                        height: 40,
                        onPressed: _init,
                        borderColor: Colors.white,
                        foregroundColor: Colors.white,
                      ),
                      CustomBorderButton(
                        width: 200,
                        margin: const EdgeInsets.only(top: 4.0),
                        splashColor: Colors.white.withOpacity(0.4),
                        highlightColor: Colors.white.withOpacity(0.2),
                        text: "Cancel",
                        height: 40,
                        onPressed: _goToLogin,
                        borderColor: Colors.transparent,
                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
