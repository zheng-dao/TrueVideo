import 'dart:async';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_twilio/flutter_twilio.dart';
import 'package:flutter_twilio/model/event.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/core/navigator_observer.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/hook/font_size.dart';
import 'package:truvideo_enterprise/main.dart';
import 'package:truvideo_enterprise/model/user.dart';
import 'package:truvideo_enterprise/riverpod/auth.dart';
import 'package:truvideo_enterprise/riverpod/debug.dart';
import 'package:truvideo_enterprise/riverpod/voip_call_status.dart';
import 'package:truvideo_enterprise/riverpod/connectivity.dart';
import 'package:truvideo_enterprise/riverpod/device_info.dart';
import 'package:truvideo_enterprise/riverpod/env.dart';
import 'package:truvideo_enterprise/riverpod/fcm_token.dart';
import 'package:truvideo_enterprise/riverpod/messaging_authentication_information.dart';
import 'package:truvideo_enterprise/riverpod/route_stack.dart';
import 'package:truvideo_enterprise/riverpod/voip_call_token.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/device/_interface.dart';
import 'package:truvideo_enterprise/service/messaging/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/service/push_notification/_interface.dart';
import 'package:truvideo_enterprise/service/settings/_interface.dart';
import 'package:truvideo_enterprise/service/settings/font_size.dart';
import 'package:truvideo_enterprise/service/voip/_interface.dart';
import 'package:truvideo_enterprise/widget/common/popup/index.dart';
import 'package:truvideo_enterprise/widget/common/video_editor/index.dart';
import 'package:truvideo_enterprise/widget/common/video_viewer/index.dart';
import 'package:truvideo_enterprise/widget/screen/active_call/index.dart';
import 'package:truvideo_enterprise/widget/screen/splash/index.dart';

import 'common/camera/index.dart';
import 'common/dialog/index.dart';
import 'common/gallery/index.dart';
import 'common/image_viewer/index.dart';
import 'common/snackbar/index.dart';
import 'common/video_tag_picker/index.dart';
import 'common/video_type_picker/index.dart';

class CustomApp extends StatefulHookConsumerWidget {
  final AppBuildMode appBuildMode;

  const CustomApp({
    Key? key,
    required this.appBuildMode,
  }) : super(key: key);

  @override
  CustomAppState createState() => CustomAppState();
}

class CustomAppState extends ConsumerState<CustomApp> with WidgetsBindingObserver {
  StreamSubscription? _pushNotificationSubscription;
  StreamSubscription? _pushNotificationAppOpenedSubscription;
  StreamSubscription? _callSubscription;

  StreamSubscription? _connectivitySubscription;
  StreamSubscription? _isDebugSubscription;

  Timer? _connectivityTimer;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    ref.read(appBuildModePod.notifier).state = widget.appBuildMode;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
    WidgetsBinding.instance.addObserver(this);
    _onForegroundChanged(true);
    super.initState();
  }

  @override
  void dispose() {
    _callSubscription?.cancel();
    _pushNotificationSubscription?.cancel();
    _pushNotificationAppOpenedSubscription?.cancel();
    _connectivitySubscription?.cancel();
    _connectivityTimer?.cancel();
    _isDebugSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _onForegroundChanged(false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final foreground = state == AppLifecycleState.resumed;
    _onForegroundChanged(foreground);
  }

  _onForegroundChanged(bool foreground) async {
    try {
      await FlutterTwilio.setForeground(foreground);
    } catch (error) {
      log("Error setting foreground", error: error);
    }
  }

  _init() async {
    CustomCamera.context = _navigatorKey.currentContext;
    CustomDialog.context = _navigatorKey.currentContext;
    CustomSnackBar.overlayState(_navigatorKey.currentState?.overlay);
    CustomImageViewer.context = _navigatorKey.currentContext;
    CustomVideoViewer.context = _navigatorKey.currentContext;
    CustomPopup.context = _navigatorKey.currentContext;
    CustomGallery.context = _navigatorKey.currentContext;
    CustomVideoEditor.context = _navigatorKey.currentContext;
    CustomVideoTagPicker.context = _navigatorKey.currentContext;
    CustomVideoTypePicker.context = _navigatorKey.currentContext;

    final DeviceService deviceService = GetIt.I.get();
    final ConnectivityService connectivityService = GetIt.I.get();

    ref.read(deviceInfoPod.notifier).state = await deviceService.getInfo();

    _connectivitySubscription = connectivityService.onlineStream.listen((event) {
      bool isOnline = event;
      ref.read(connectivityPod.notifier).state = isOnline;
    });

    _connectivityTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      bool isOnline = await connectivityService.isOnline();
      ref.read(connectivityPod.notifier).state = isOnline;
    });
  }

  _initNotifications() {
    final PushNotificationService pushNotificationService = GetIt.I.get();

    _pushNotificationSubscription?.cancel();
    _pushNotificationSubscription = pushNotificationService.onMessage.listen(_handleNotification);

    _pushNotificationAppOpenedSubscription?.cancel();
    _pushNotificationAppOpenedSubscription = pushNotificationService.onMessageOpenedApp.listen(_handleAppOpenFromNotification);

    pushNotificationService.getInitialMessage().then((value) {
      if (value == null) return;
      _handleAppOpenFromNotification(value);
    });
  }

  _disposeNotifications() {
    _pushNotificationSubscription?.cancel();
    _pushNotificationSubscription = null;
    _pushNotificationAppOpenedSubscription?.cancel();
    _pushNotificationAppOpenedSubscription = null;
  }

  _handleNotification(RemoteMessage remoteMessage) {
    // Handle incoming call
    if (remoteMessage.data.containsKey("twi_message_type") && remoteMessage.data["twi_message_type"] == "twilio.voice.call") {
      return;
    }

    // if (_isOnCallScreen) return;

    showCustomSnackBar(
      title: remoteMessage.notification?.title ?? "",
      body: remoteMessage.notification?.body ?? "",
      icon: Icons.notifications,
      iconBackgroundColor: Colors.blue.shade600,
    );
  }

  _handleAppOpenFromNotification(RemoteMessage remoteMessage) {
    showCustomDialog(
      title: "App opened from notification",
      builder: (context, controller) => SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              remoteMessage.notification?.title ?? "",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(remoteMessage.notification?.body ?? ""),
          ],
        ),
      ),
    );
  }

  _onLogin() async {
    log("On login");

    final user = ref.read(authPod);
    FirebaseCrashlytics.instance.setUserIdentifier(user?.publicUserUuid ?? "");

    _initNotifications();
    final OfflineEnqueueService offlineEnqueueService = GetIt.I.get();
    offlineEnqueueService.startService();

    // Twilio
    _initTwilio();

    // Refresh debug pod from setting stream
    SettingsService settingsService = GetIt.I.get();
    _isDebugSubscription?.cancel();
    _isDebugSubscription = settingsService.streamIsDebug().listen((event) {
      ref.read(debugPod.notifier).state = event;
    });
  }

  _onLogout() {
    log("On logout");
    _disposeNotifications();
    _disposeTwilio();

    FirebaseCrashlytics.instance.setUserIdentifier("");
    _isDebugSubscription?.cancel();
  }

  _initTwilio() async {
    log("Register calls from twilio");

    final call = await FlutterTwilio.getActiveCall();
    if (call != null) {
      _goToCallScreen();
    }

    _callSubscription?.cancel();
    _callSubscription = FlutterTwilio.onCallConnecting.listen(_onCallConnecting);
  }

  _onCallConnecting(FlutterTwilioEvent event) {
    _goToCallScreen();
  }

  _disposeTwilio() {
    log("Unregister calls from twilio");

    _callSubscription?.cancel();
    _callSubscription = null;
  }

  bool get _isOnCallScreen {
    final routes = ref.read(routeStackPod);
    if (routes.isNotEmpty) {
      final last = routes.last;
      return last.settings.name == ScreenActiveCall.routeName;
    }

    return false;
  }

  _goToCallScreen() {
    if (_isOnCallScreen) return;

    _navigatorKey.currentState?.pushNamed(
      ScreenActiveCall.routeName,
      arguments: ScreenActiveCallParams(),
    );
  }

  _onRoutesChanged(List<Route> routes) {
    ref.read(routeStackPod.notifier).state = routes;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CustomKeyboardUtils.hide();
    });
  }

  registerVoipCalls() async {
    final MessagingService messagingService = GetIt.I.get();
    final PushNotificationService pushNotificationService = GetIt.I.get();
    final VoipService voipService = GetIt.I.get();
    final AuthService authService = GetIt.I.get();

    ref.read(voipCallStatusPod.notifier).state = VoipCallStatus.loading;

    try {
      final user = await authService.isLogin();
      if (user == null) {
        try {
          await authService.logout();
        } catch (_) {}
        _goToLogin();
        return;
      }

      final authenticationInformation = await messagingService.authenticate();
      if (authenticationInformation == null || authenticationInformation.subjectMessageableEntity == null) {
        throw CustomException();
      }

      final twilioToken = await voipService.register(
        uid: authenticationInformation.subjectMessageableEntity!.uid,
        accountUID: authenticationInformation.accountUID,
      );

      if (twilioToken == null) {
        throw CustomException();
      }

      final fcmToken = await pushNotificationService.getToken();
      await FlutterTwilio.register(
        identity: twilioToken.identity,
        accessToken: twilioToken.token,
        fcmToken: fcmToken,
      );

      ref.read(voipCallStatusPod.notifier).state = VoipCallStatus.ready;
      ref.read(fcmTokenPod.notifier).state = fcmToken;
      ref.read(messagingAuthenticationInformationPod.notifier).state = authenticationInformation;
      ref.read(voipCallTokenPod.notifier).state = twilioToken;
      ref.read(authPod.notifier).state = user;
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);
      if (!mounted) return;
      ref.read(voipCallStatusPod.notifier).state = VoipCallStatus.error;
    }
  }

  _goToLogin() {
    Navigator.of(context).pushReplacementNamed(ScreenSplash.routeName);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserModel?>(authPod, (previous, next) {
      if (next != null) {
        _onLogin();
      } else {
        _onLogout();
      }
    });

    ref.listen<bool>(connectivityPod, (previous, next) {
      final loggedIn = ref.read(authPod) != null;
      if (!loggedIn) return;

      if (next) {
        registerVoipCalls();
      } else {
        ref.read(voipCallStatusPod.notifier).state = VoipCallStatus.nothing;
      }
    });

    final SettingsFontSize fontSize = useFontSize(ref);

    TextStyle? _textStyle(TextStyle? style, int size) {
      return style?.copyWith(fontSize: size * fontSize.scale);
    }

    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: "TruVideo PRO",
      navigatorObservers: [CustomNavigatorObserver(onChange: _onRoutesChanged)],
      onGenerateRoute: CustomRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(accentColor: CustomColorsUtils.accent),
        cardColor: Colors.white,
        dividerColor: CustomColorsUtils.divider,
        textTheme: GoogleFonts.openSansTextTheme().copyWith(
          bodySmall: _textStyle(GoogleFonts.openSansTextTheme().bodySmall, 12),
          bodyMedium: _textStyle(GoogleFonts.openSansTextTheme().bodyMedium, 14),
          bodyLarge: _textStyle(GoogleFonts.openSansTextTheme().bodyLarge, 16),
          titleSmall: _textStyle(GoogleFonts.openSansTextTheme().titleSmall, 20),
          titleMedium: _textStyle(GoogleFonts.openSansTextTheme().titleMedium, 22),
          titleLarge: _textStyle(GoogleFonts.openSansTextTheme().titleLarge, 24),
          displaySmall: _textStyle(GoogleFonts.openSansTextTheme().displaySmall, 22),
          displayMedium: _textStyle(GoogleFonts.openSansTextTheme().displayMedium, 28),
          displayLarge: _textStyle(GoogleFonts.openSansTextTheme().displayLarge, 32),
          labelSmall: _textStyle(GoogleFonts.openSansTextTheme().labelSmall, 12),
          labelMedium: _textStyle(GoogleFonts.openSansTextTheme().labelMedium, 14),
          labelLarge: _textStyle(GoogleFonts.openSansTextTheme().labelLarge, 16),
          headlineSmall: _textStyle(GoogleFonts.openSansTextTheme().headlineSmall, 14),
          headlineMedium: _textStyle(GoogleFonts.openSansTextTheme().headlineMedium, 16),
          headlineLarge: _textStyle(GoogleFonts.openSansTextTheme().headlineLarge, 18),
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: CustomColorsUtils.accent,
          foregroundColor: CustomColorsUtils.accent.contrast(context),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(Colors.white.contrast(context).withOpacity(0.1)),
            elevation: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.pressed)) return 8.0;
                return 2.0;
              },
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
            textStyle: MaterialStateProperty.all(
              GoogleFonts.openSansTextTheme().bodyMedium?.copyWith(
                    color: Colors.white.contrast(context),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
            ),
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColorsUtils.textFieldBorder, width: 1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColorsUtils.textFieldFocusedBorder, width: 1),
          ),
        ),
      ),
      home: const ScreenSplash(),
      builder: (context, child) => GestureDetector(
        onTap: () {
          CustomKeyboardUtils.hide();
        },
        child: child,
      ),
    );
  }
}
