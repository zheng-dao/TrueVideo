import 'dart:async';
import 'dart:developer';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/hook/camera_quality.dart';
import 'package:truvideo_enterprise/hook/font_size.dart';
import 'package:truvideo_enterprise/hook/is_biometric_login_configured.dart';
import 'package:truvideo_enterprise/model/user_settings.dart';
import 'package:truvideo_enterprise/riverpod/auth.dart';
import 'package:truvideo_enterprise/riverpod/debug.dart';
import 'package:truvideo_enterprise/riverpod/env.dart';
import 'package:truvideo_enterprise/riverpod/fcm_token.dart';
import 'package:truvideo_enterprise/riverpod/messaging_authentication_information.dart';
import 'package:truvideo_enterprise/riverpod/package_info.dart';
import 'package:truvideo_enterprise/riverpod/user_settings.dart';
import 'package:truvideo_enterprise/riverpod/voip_call_token.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/service/settings/_interface.dart';
import 'package:truvideo_enterprise/service/settings/camera_quality.dart';
import 'package:truvideo_enterprise/service/settings/font_size.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/camera/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/controller.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/json_viewer/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/snackbar/index.dart';
import 'package:truvideo_enterprise/widget/screen/file_explorer/index.dart';
import 'package:truvideo_enterprise/widget/screen/offline_queue/index.dart';
import 'package:truvideo_enterprise/widget/screen/setting/confetti.dart';
import 'package:truvideo_enterprise/widget/screen/setting/healthcheck_dialog.dart';
import 'package:truvideo_enterprise/widget/screen/setting_biometric/index.dart';

class ScreenSettingsParams {
  CustomRouteType? routeType;

  ScreenSettingsParams({this.routeType});
}

class ScreenSettings extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenSettings";
  final ScreenSettingsParams params;

  const ScreenSettings({Key? key, required this.params}) : super(key: key);

  @override
  ConsumerState<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends ConsumerState<ScreenSettings> {
  AuthService get _authService => GetIt.I.get();

  DateService get _dateService => GetIt.I.get();

  late ConfettiController _animationConfettiController;
  int _devClicks = 0;
  Timer? _devTimer;

  @override
  void initState() {
    super.initState();
    _animationConfettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _animationConfettiController.dispose();
    super.dispose();
  }

  _close() {
    Navigator.of(context).pop();
  }

  _onVersionPressed() {
    final debug = ref.read(debugPod);
    if (debug) return;

    setState(() => _devClicks += 1);
    _devTimer?.cancel();

    if (_devClicks == 7) {
      _animationConfettiController.play();
      final SettingsService settingsService = GetIt.I.get();
      settingsService.setDebug(true);
      _devClicks = 0;
    } else {
      _devTimer = Timer(const Duration(milliseconds: 500), () {
        setState(() => _devClicks = 0);
      });
    }
  }

  _onFcmTokenPressed() async {
    final data = ref.read(fcmTokenPod);

    final expirationDate = _authService.tokenExpiration;

    await showCustomDialog(
      title: "FCM Token",
      builder: (context, controller) => Text(data),
      buttonsBuilder: (context, controller) => [
        if (data.trim().isNotEmpty)
          CustomBorderButton.small(
            text: "Copy",
            onPressed: () {
              Clipboard.setData(ClipboardData(text: data));
              controller.close();
            },
          ),
        CustomBorderButton.small(
          text: "Accept",
          onPressed: controller.close,
        ),
      ],
    );
  }

  _onAuthenticationInformationPressed() async {
    final data = ref.read(messagingAuthenticationInformationPod);

    await showCustomDialog(
      title: "Authentication information",
      builder: (context, controller) => CustomJsonViewer(
        json: data?.toJson() ?? <String, String>{},
      ),
      buttonsBuilder: (context, controller) => [
        if (data != null)
          CustomBorderButton.small(
            text: "Copy",
            onPressed: () {
              Clipboard.setData(ClipboardData(text: data.toJson().toString()));
              controller.close();
            },
          ),
        CustomBorderButton.small(
          text: "Accept",
          onPressed: controller.close,
        ),
      ],
    );
  }

  _onVoipCallTokenPressed() async {
    final data = ref.read(voipCallTokenPod);

    await showCustomDialog(
      title: "Voip Call Token",
      builder: (context, controller) => CustomJsonViewer(
        json: data?.toJson() ?? <String, String>{},
      ),
      buttonsBuilder: (context, controller) => [
        if (data != null)
          CustomBorderButton.small(
            text: "Copy",
            onPressed: () {
              Clipboard.setData(ClipboardData(text: data.toJson().toString()));
              controller.close();
            },
          ),
        CustomBorderButton.small(
          text: "Accept",
          onPressed: controller.close,
        ),
      ],
    );
  }

  _onTruvideoTokenPressed() async {
    final data = (await _authService.token) ?? "";
    var expirationDate = _authService.tokenExpiration;

    await showCustomDialog(
      title: "Truvideo JWT token",
      builder: (context, CustomDialogController controller) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data),
          const SizedBox(height: 16),
          if (expirationDate != null) Text("Expiration date: ${_dateService.formatDateTime(expirationDate!)}"),
          if (expirationDate != null) const SizedBox(height: 16),
          CustomBorderButton.small(
            text: "Refresh token",
            onPressed: () async {
              try {
                controller.setLoading(true);
                await _authService.refreshToken();
                expirationDate = _authService.tokenExpiration;
                controller.refresh();
                controller.setLoading(false);
                showCustomSnackBarSuccess(title: "Token refreshed successfully");
              } catch (error) {
                log("Error refreshing token", error: error);
                controller.setLoading(false);

                showCustomDialogRetry(
                  error: error,
                  retryButtonText: "Accept",
                  cancelButtonVisible: false,
                );
              }
            },
          ),
        ],
      ),
      buttonsBuilder: (context, controller) => [
        if (data.trim().isNotEmpty)
          CustomBorderButton.small(
            text: "Copy",
            onPressed: () {
              Clipboard.setData(ClipboardData(text: data.toString()));
              controller.close();
            },
          ),
        CustomBorderButton.small(
          text: "Accept",
          onPressed: controller.close,
        ),
      ],
    );
  }

  _goToOfflineQueue() {
    Navigator.of(context).pushNamed(ScreenOfflineQueue.routeName);
  }

  _goToFileExplorer() {
    Navigator.of(context).pushNamed(
      ScreenFileExplorer.routeName,
      arguments: ScreenFileExplorerParams(),
    );
  }

  _autoHealthCheck() async {
    showCustomDialog(
        title: "Auto-Healthcheck",
        builder: (context, controller) => AutoHealthCheckDialog(
              onFinish: () => controller.close(),
            ));
  }

  _goToCamera() {
    showCustomCameraVideo();
  }

  _onFontSizePressed() async {
    final SettingsService settingsService = GetIt.I.get();
    final fontSize = await settingsService.getFontSize();

    showCustomDialog(
      title: "Font size",
      childPadding: EdgeInsets.zero,
      builder: (context, controller) => CustomList<SettingsFontSize>.separated(
        areItemsTheSame: (a, b) => a == b,
        shrinkWrap: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, item) => CustomListTile(
          dense: true,
          titleText: item.name,
          trailing: Icon(
            fontSize == item ? Icons.check_circle : Icons.circle_outlined,
            color: fontSize == item ? Theme.of(context).colorScheme.secondary : null,
          ),
          onPressed: () {
            controller.close();
            settingsService.setFontSize(item);
          },
        ),
        data: SettingsFontSize.values,
      ),
    );
  }

  _onCameraQualityPressed() async {
    final SettingsService settingsService = GetIt.I.get();
    final cameraQuality = await settingsService.getCameraQuality();

    await showCustomDialog(
      title: "Camera Quality",
      childPadding: EdgeInsets.zero,
      builder: (context, controller) => CustomList<CameraQuality>.separated(
        areItemsTheSame: (a, b) => a == b,
        shrinkWrap: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, item) => CustomListTile(
          dense: true,
          titleText: item.name,
          trailing: Icon(
            cameraQuality == item ? Icons.check_circle : Icons.circle_outlined,
            color: cameraQuality == item ? Theme.of(context).colorScheme.secondary : null,
          ),
          onPressed: () {
            controller.close();
            settingsService.setCameraQuality(item);
          },
        ),
        data: CameraQuality.values,
      ),
    );
  }

  _onUserSettingsPressed() async {
    final List<UserSettingsModel>? data = ref.watch(userSettingsPod);

    final json = <String, dynamic>{};
    data?.forEach((element) {
      json[element.key] = element.toJson();
    });

    await showCustomDialog(
      title: "User settings",
      builder: (context, controller) => CustomJsonViewer(json: json),
      childPadding: EdgeInsets.zero,
      buttonsBuilder: (context, controller) => [
        if (data != null)
          CustomBorderButton.small(
            text: "Copy",
            onPressed: () {
              Clipboard.setData(ClipboardData(text: data.map((e) => e.toJson()).toList().toString()));
              controller.close();
            },
          ),
        CustomBorderButton.small(
          text: "Accept",
          onPressed: controller.close,
        ),
      ],
    );
  }

  _cancelDebug() {
    SettingsService settingsService = GetIt.I.get();
    settingsService.setDebug(false);
  }

  _onBiometricPressed() {
    Navigator.of(context).pushNamed(
      ScreenSettingsBiometric.routeName,
      arguments: ScreenSettingsBiometricParams(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRouteTypeCupertinoVertical = widget.params.routeType == CustomRouteType.cupertinoVertical;
    Color appBarFillColor;
    Color appBarIconColor;
    Color fillColor = CustomColorsUtils.chatBackground;
    if (isRouteTypeCupertinoVertical) {
      appBarFillColor = CustomColorsUtils.chatBackground;
    } else {
      appBarFillColor = Theme.of(context).colorScheme.secondary;
    }
    appBarIconColor = appBarFillColor.contrast(context);

    final buttonClose = CustomButtonIcon(
      icon: isRouteTypeCupertinoVertical ? Icons.clear : Icons.arrow_back_ios,
      backgroundColor: Colors.transparent,
      iconColor: appBarIconColor,
      onPressed: _close,
    );

    final appBuildMode = ref.watch(appBuildModePod);
    final debug = ref.watch(debugPod);
    final packageInfo = ref.watch(packageInfoPod).value;
    final fontSize = useFontSize(ref);
    final cameraQuality = useCameraQuality(ref);
    final userBiometric = useIsBiometricLoginConfigured(ref);

    final user = ref.watch(authPod);
    final fcmToken = ref.watch(fcmTokenPod);
    final voipCallToken = ref.watch(voipCallTokenPod);
    final truvideoJWTToken = useFuture(useMemoized(() => _authService.token, [user?.publicUserUuid])).data ?? "";
    final messagingAuthenticationInformation = ref.read(messagingAuthenticationInformationPod);

    return Stack(
      children: [
        Positioned.fill(
          child: CustomScaffold(
            backgroundColor: CustomColorsUtils.chatBackground,
            appbar: CustomAppBar(
              title: "Settings",
              titleColor: appBarIconColor,
              backgroundColor: appBarFillColor,
              leading: isRouteTypeCupertinoVertical ? null : buttonClose,
              actionButtons: isRouteTypeCupertinoVertical ? [buttonClose] : [],
            ),
            body: CustomFadingEdgeList(
              color: fillColor,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16.0).copyWith(bottom: 16.0 + MediaQuery.of(context).viewPadding.bottom),
                child: Column(
                  children: [
                    CustomAnimatedCollapseVisibility(
                      visible: debug,
                      child: const CustomListTile(
                        titleText: "Settings",
                        dense: true,
                      ),
                    ),
                    CustomListTile(
                      color: Colors.white,
                      titleText: "Font Size",
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(fontSize.name),
                          const SizedBox(width: 4.0),
                          Icon(Icons.keyboard_arrow_down, size: 14, color: Theme.of(context).textTheme.caption?.color),
                        ],
                      ),
                      onPressed: _onFontSizePressed,
                    ),
                    const CustomDivider(),
                    CustomListTile(
                      color: Colors.white,
                      titleText: "Camera Quality",
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(cameraQuality.name),
                          const SizedBox(width: 4.0),
                          Icon(Icons.keyboard_arrow_down, size: 14, color: Theme.of(context).textTheme.caption?.color),
                        ],
                      ),
                      onPressed: _onCameraQualityPressed,
                    ),
                    const CustomDivider(),
                    CustomListTile(
                      color: Colors.white,
                      titleText: "Biometric login",
                      subtitleText: "Tap to configure",
                      onPressed: _onBiometricPressed,
                      trailing: CustomAnimatedFadeVisibility(
                        visible: userBiometric,
                        child: const CustomListTileImage(
                          color: Colors.transparent,
                          icon: Icons.check,
                        ),
                      ),
                    ),
                    const CustomDivider(),
                    CustomListTile(
                      color: Colors.white,
                      titleText: "Version",
                      subtitleText: "${packageInfo?.version ?? ""} (${packageInfo?.buildNumber ?? ""})",
                      onPressed: debug ? null : _onVersionPressed,
                    ),
                    CustomAnimatedCollapseVisibility(
                      visible: debug,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          const CustomListTile(
                            titleText: "Debug settings",
                            dense: true,
                          ),
                          CustomListTile(
                            titleText: "Build Mode",
                            subtitleText: appBuildMode?.name ?? "",
                            color: Colors.white,
                          ),
                          const CustomDivider(),
                          CustomListTile(
                            titleText: "User settings",
                            subtitleText: "Tap to see",
                            onPressed: _onUserSettingsPressed,
                            color: Colors.white,
                          ),
                          const CustomDivider(),
                          CustomListTile(
                            titleText: "FCM Token",
                            subtitleText: fcmToken.trim().isEmpty ? "No data" : "Tap to see",
                            onPressed: fcmToken.trim().isEmpty ? null : _onFcmTokenPressed,
                            color: Colors.white,
                          ),
                          const CustomDivider(),
                          CustomListTile(
                            titleText: "Truvideo JWT Token",
                            subtitleText: truvideoJWTToken.trim().isEmpty ? "No data" : "Tap to see",
                            onPressed: truvideoJWTToken.trim().isEmpty ? null : _onTruvideoTokenPressed,
                            color: Colors.white,
                          ),
                          const CustomDivider(),
                          CustomListTile(
                            titleText: "Messaging authentication information",
                            subtitleText: messagingAuthenticationInformation == null ? "No data" : "Tap to see",
                            onPressed: messagingAuthenticationInformation == null ? null : _onAuthenticationInformationPressed,
                            color: Colors.white,
                          ),
                          const CustomDivider(),
                          CustomListTile(
                            titleText: "Voip call token",
                            subtitleText: voipCallToken == null ? "No data" : "Tap to see",
                            onPressed: voipCallToken == null ? null : _onVoipCallTokenPressed,
                            color: Colors.white,
                          ),
                          const CustomDivider(),
                          CustomListTile(
                            titleText: "Offline queue",
                            subtitleText: "Tap to go",
                            onPressed: _goToOfflineQueue,
                            color: Colors.white,
                          ),
                          const CustomDivider(),
                          CustomListTile(
                            titleText: "File explorer",
                            subtitleText: "Tap to go",
                            onPressed: _goToFileExplorer,
                            color: Colors.white,
                          ),
                          const CustomDivider(),
                          CustomListTile(
                            titleText: "Auto Healthcheck",
                            subtitleText: "Tap to run",
                            onPressed: _autoHealthCheck,
                            color: Colors.white,
                          ),
                          const CustomDivider(),
                          CustomListTile(
                            color: Colors.white,
                            titleText: "Open camera",
                            subtitleText: "Tap to go",
                            onPressed: _goToCamera,
                          ),
                          Center(
                            child: CustomBorderButton(
                              margin: const EdgeInsets.only(top: 16.0),
                              text: "Hide debug information",
                              height: 40,
                              fillColor: Colors.white,
                              borderColor: Colors.grey.shade400,
                              onPressed: _cancelDebug,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ScreenSettingsConfetti(controller: _animationConfettiController),
      ],
    );
  }
}
