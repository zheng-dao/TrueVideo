import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/model/support_info.dart';
import 'package:truvideo_enterprise/service/support/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/container/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/screen/send_support_info/index.dart';
import 'package:truvideo_enterprise/widget/screen/support/shimmer.dart';

import 'speed_test_button.dart';

class ScreenSupportParams {
  CustomRouteType? routeType;

  ScreenSupportParams({this.routeType});
}

class ScreenSupport extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenSupport";

  final ScreenSupportParams params;

  const ScreenSupport({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  ConsumerState<ScreenSupport> createState() => _ScreenSupportState();
}

class _ScreenSupportState extends ConsumerState<ScreenSupport> {
  SupportInfoModel? _supportInfo;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  _init() async {
    SupportService service = GetIt.I.get();
    try {
      setState(() {
        _loading = true;
      });

      final supportInfo = await service.getInfo();
      setState(() {
        _loading = false;
        _supportInfo = supportInfo;
      });
    } catch (error) {
      log("Error getting setting information: $error");
      if (!mounted) return;

      setState(() {
        _loading = false;
      });

      final retry = await showCustomDialogRetry();
      if (!mounted) return;

      if (retry) {
        _init();
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  _onButtonContinuePressed(double speed) async {
    setState(() {
      _supportInfo = _supportInfo?.copyWith(bandwidthTest: "${speed.toStringAsFixed(2)} MB/s");
    });

    final supportInfo = _supportInfo;
    if (supportInfo == null) return;

    await Navigator.of(context).pushNamed(
      SendSupportInfoScreen.routeName,
      arguments: SendSupportInfoScreenParams(
        supportInfo: supportInfo,
      ),
    );
  }

  _close() {
    Navigator.of(context).pop();
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

    return CustomScaffold(
      backgroundColor: fillColor,
      appbar: CustomAppBar(
        title: "Support",
        titleColor: appBarIconColor,
        backgroundColor: appBarFillColor,
        leading: isRouteTypeCupertinoVertical ? null : buttonClose,
        actionButtons: isRouteTypeCupertinoVertical ? [buttonClose] : [],
      ),
      body: Stack(
        children: [
          CustomContainer(
            mode: _loading ? CustomContainerMode.loading : CustomContainerMode.normal,
            loadingBuilder: (context) => const ScreenSupportShimmer(),
            builder: (context) => CustomFadingEdgeList(
              color: CustomColorsUtils.chatBackground,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomListTile(titleText: "Account info", dense: true),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          _rowInfo("Dealer Name", _supportInfo?.dealerName ?? "-"),
                          _rowInfo("Dealer ID", _supportInfo?.dealerUuid ?? "-"),
                          _rowInfo("User ID", _supportInfo?.userId ?? "-"),
                        ],
                      ),
                    ),
                    const CustomListTile(titleText: "App/Device info", dense: true),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          _rowInfo("App Version", _supportInfo?.appVersion ?? "-"),
                          _rowInfo("Date/Time", _supportInfo?.dateTime ?? "-"),
                          _rowInfo("Phone ID", _supportInfo?.phoneId ?? "-"),
                          _rowInfo("Phone Type", _supportInfo?.phoneType ?? "-"),
                          _rowInfo("Phone OS Version", _supportInfo?.phoneOS ?? "-"),
                          _rowInfo("Battery", _supportInfo?.batteryLevel ?? "-"),
                        ],
                      ),
                    ),
                    const CustomListTile(titleText: "Device Memory", dense: true),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          _rowInfo("Free Memory", _supportInfo?.freeVirtualMemory ?? "-"),
                          _rowInfo("Total Memory", _supportInfo?.totalPhysicalMemory ?? "-"),
                          _rowInfo("Internal Storage", _supportInfo?.freeDiskSpace ?? "-"),
                          _rowInfo("External Storage", _supportInfo?.freeExternalStorage ?? "-"),
                          _rowInfo("Video Stored", _supportInfo?.videoStored ?? "-"),
                        ],
                      ),
                    ),
                    const CustomListTile(titleText: "Permissions", dense: true),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          _rowInfo("Has Access to Microphone", _supportInfo?.microphoneAccess ?? "-"),
                          _rowInfo("Notifications", _supportInfo?.notificationAccess ?? "-"),
                        ],
                      ),
                    ),
                    const CustomListTile(titleText: "Video Settings", dense: true),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          _rowInfo("Recording Settings", _supportInfo?.recordingSettings ?? "-"),
                          _rowInfo("Video Format", _supportInfo?.videoFormat ?? "-"),
                        ],
                      ),
                    ),
                    const CustomListTile(titleText: "Network status", dense: true),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          _rowInfo("Wifi/Internet Settings", _supportInfo?.wifiInternetSettings ?? "-"),
                          _rowInfo("TruVideo Server", _supportInfo?.truVideoServer ?? "-"),
                          _rowInfo("Network Type", _supportInfo?.networkType ?? "-"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      navigationBar: CustomAnimatedFadeVisibility(
        visible: !_loading,
        child: Container(
          margin: const EdgeInsets.all(16.0).copyWith(bottom: 16.0 + MediaQuery.of(context).viewPadding.bottom),
          child: CustomSpeedTestButton(
            onPressed: _onButtonContinuePressed,
          ),
        ),
        // child: CustomGradientButton(
        //   margin: const EdgeInsets.all(16.0).copyWith(bottom: 16.0 + MediaQuery.of(context).viewPadding.bottom),
        //   gradient: CustomColorsUtils.gradient,
        //   onPressed: _onButtonContinuePressed,
        //   text: "CONTINUE",
        // ),
      ),
    );
  }

  Widget _rowInfo(String title, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(
              info,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
