import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:truvideo_enterprise/widget/screen/active_call/index.dart';
import 'package:truvideo_enterprise/widget/screen/advisor_picker/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/index.dart';
import 'package:truvideo_enterprise/widget/screen/file_explorer/index.dart';
import 'package:truvideo_enterprise/widget/screen/home/index.dart';
import 'package:truvideo_enterprise/widget/screen/login/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_pin/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_list/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_new/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_new_pin/index.dart';
import 'package:truvideo_enterprise/widget/screen/message_channel_info/index.dart';
import 'package:truvideo_enterprise/widget/screen/message_list/index.dart';
import 'package:truvideo_enterprise/widget/screen/not-found/index.dart';
import 'package:truvideo_enterprise/widget/screen/offline_queue/index.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order/index.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order_new/index.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order_search_list/index.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order_upload_video_request/index.dart';
import 'package:truvideo_enterprise/widget/screen/send_support_info/index.dart';
import 'package:truvideo_enterprise/widget/screen/setting/index.dart';
import 'package:truvideo_enterprise/widget/screen/setting_biometric/index.dart';
import 'package:truvideo_enterprise/widget/screen/splash/index.dart';
import 'package:truvideo_enterprise/widget/screen/user_logout/index.dart';
import 'package:truvideo_enterprise/widget/screen/support/index.dart';

import 'fade_page_route.dart';
import 'sheet_container.dart';

class CustomRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final focusRouteType = Platform.isIOS ? CustomRouteType.cupertinoVertical : CustomRouteType.cupertino;
    const normalRouteType = CustomRouteType.cupertino;

    switch (settings.name) {
      case ScreenSplash.routeName:
        return _fadeRoute(settings, const ScreenSplash());

      case ScreenLogin.routeName:
        return _fadeRoute(settings, const ScreenLogin());

      case ScreenLoginUserList.routeName:
        return _fadeRoute(settings, const ScreenLoginUserList());

      case ScreenLoginUserPin.routeName:
        final params = settings.arguments as ScreenLoginUserPinParams;
        params.routeType ??= focusRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenLoginUserPin(params: params),
        );

      case ScreenLoginUserNew.routeName:
        final params = settings.arguments as ScreenLoginUserNewParams;
        params.routeType ??= focusRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenLoginUserNew(params: params),
        );

      case ScreenLoginUserNewPin.routeName:
        final params = settings.arguments as ScreenLoginUserNewPinParams;
        params.routeType ??= focusRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenLoginUserNewPin(params: params),
        );

      case ScreenRepairOrderSearchList.routeName:
        return _fadeRoute(settings, const ScreenRepairOrderSearchList());

      case ScreenRepairOrder.routeName:
        final params = settings.arguments as ScreenRepairOrderParams;
        params.routeType ??= normalRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenRepairOrder(params: params),
        );

      case ScreenRepairOrderVideoUploadRequest.routeName:
        final params = settings.arguments as ScreenRepairOrderVideoUploadRequestParams;
        params.routeType ??= normalRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenRepairOrderVideoUploadRequest(params: params),
        );

      case ScreenHome.routeName:
        return _buildRoute(
          CustomRouteType.alpha,
          settings: settings,
          child: const ScreenHome(),
        );

      case ScreenRepairOrderNew.routeName:
        final params = settings.arguments as ScreenRepairOrderNewParams;
        params.routeType ??= focusRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenRepairOrderNew(params: params),
        );

      case ScreenAdvisorPicker.routeName:
        final params = settings.arguments as ScreenAdvisorPickerParams;
        params.routeType ??= focusRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenAdvisorPicker(params: params),
        );

      case ScreenMessageList.routeName:
        return customCupertinoRoute(
          child: const ScreenMessageList(),
          settings: settings,
        );

      case ScreenMessageChannelInfo.routeName:
        return customCupertinoRoute(
          child: const ScreenMessageChannelInfo(),
          settings: settings,
        );

      case ScreenSettings.routeName:
        final params = settings.arguments as ScreenSettingsParams;
        params.routeType ??= focusRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenSettings(params: params),
        );

      case ScreenSettingsBiometric.routeName:
        final params = settings.arguments as ScreenSettingsBiometricParams;
        params.routeType ??= focusRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenSettingsBiometric(params: params),
        );

      case ScreenSupport.routeName:
        final params = settings.arguments as ScreenSupportParams;
        params.routeType ??= focusRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenSupport(params: params),
        );

      case SendSupportInfoScreen.routeName:
        final params = settings.arguments as SendSupportInfoScreenParams;
        params.routeType ??= focusRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: SendSupportInfoScreen(params: params),
        );

      case ScreenOfflineQueue.routeName:
        return customCupertinoRoute(
          child: const ScreenOfflineQueue(),
          settings: settings,
        );

      case ScreenActiveCall.routeName:
        return _fadeRoute(settings, const ScreenActiveCall());

      case ScreenFileExplorer.routeName:
        final params = settings.arguments as ScreenFileExplorerParams;
        params.routeType ??= focusRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenFileExplorer(params: params),
        );

      case ScreenChecklist.routeName:
        final params = settings.arguments as ScreenChecklistParams;
        params.routeType ??= focusRouteType;

        return _buildRoute(
          params.routeType!,
          settings: settings,
          child: ScreenChecklist(params: params),
        );

      case ScreenUserLogout.routeName:
        return _fadeRoute(settings, const ScreenUserLogout());
    }

    return _fadeRoute(settings, const ScreenNotFound());
  }
}

Route<dynamic>? _fadeRoute(RouteSettings settings, Widget child) => CustomPageRoute(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      settings: settings,
    );

Route<dynamic>? _buildRoute(
  CustomRouteType type, {
  required RouteSettings settings,
  required Widget child,
}) {
  switch (type) {
    case CustomRouteType.alpha:
      return _fadeRoute(
        settings,
        child,
      );

    case CustomRouteType.cupertino:
      return customCupertinoRoute(
        child: child,
        settings: settings,
      );
    case CustomRouteType.cupertinoVertical:
      return customCupertinoModalBottomSheetRoute(
        child: child,
        settings: settings,
      );
  }
}

enum CustomRouteType {
  alpha,
  cupertino,
  cupertinoVertical,
}

Route<dynamic> customCupertinoModalBottomSheetRoute({
  required Widget child,
  RouteSettings? settings,
}) =>
    CupertinoModalBottomSheetRoute(
      builder: (context) => child,
      containerBuilder: (context, _, child) => CupertinoBottomSheetContainer(child: child),
      expanded: true,
      elevation: 16.0,
      isDismissible: true,
      topRadius: kDefaultTopRadius,
      duration: const Duration(milliseconds: 300),
      settings: settings,
    );

Route<dynamic> customCupertinoRoute({
  RouteSettings? settings,
  required Widget child,
}) =>
    MaterialWithModalsPageRoute(
      builder: (context) => child,
      settings: settings,
    );
