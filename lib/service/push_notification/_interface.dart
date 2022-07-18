import 'package:firebase_messaging/firebase_messaging.dart';

abstract class PushNotificationService {
  Future<bool> hasPermission();

  Future<bool> requestPermission();

  Future<String?> updateToken();

  Stream<RemoteMessage> get onMessage;

  Stream<RemoteMessage> get onMessageOpenedApp;

  Future<RemoteMessage?> getInitialMessage();

  Future<String> getToken();

  Future<void> revokeToken();

  Stream<String?> get tokenStream;
}
