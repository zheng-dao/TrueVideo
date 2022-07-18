import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';

import '_interface.dart';

class PushNotificationServiceImpl implements PushNotificationService {
  PushNotificationServiceImpl();

  HttpService get httpService => GetIt.I.get();

  @override
  Stream<RemoteMessage> get onMessage {
    return FirebaseMessaging.onMessage.asBroadcastStream();
  }

  @override
  Stream<RemoteMessage> get onMessageOpenedApp {
    return FirebaseMessaging.onMessageOpenedApp.asBroadcastStream();
  }

  @override
  Future<RemoteMessage?> getInitialMessage() async {
    return FirebaseMessaging.instance.getInitialMessage();
  }

  @override
  Future<String?> updateToken() async {
    await FirebaseMessaging.instance.deleteToken();
    return getToken();
  }

  @override
  Stream<String?> get tokenStream {
    StreamSubscription? streamSubscription;
    final streamController = StreamController<String?>.broadcast(
      onCancel: () {
        streamSubscription?.cancel();
      },
    );

    FirebaseMessaging.instance.getToken().then((value) {
      streamController.add(value);

      streamSubscription = FirebaseMessaging.instance.onTokenRefresh.listen((event) {
        streamController.add(event);
      });
    });

    return streamController.stream;
  }

  @override
  Future<String> getToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      return token ?? "no-token";
    } catch (error, stack) {
      log("Error getting fcm token", error: error, stackTrace: stack);
      return "no-token";
    }
  }

  @override
  Future<void> revokeToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  @override
  Future<bool> hasPermission() async {
    final NotificationSettings settings = await FirebaseMessaging.instance.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  Future<bool> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );

    return hasPermission();
  }
}
