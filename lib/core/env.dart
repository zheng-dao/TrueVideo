import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/main.dart';

class CustomEnv {
  static String getBaseTruvideoURL(AppBuildMode mode) {
    switch (mode) {
      case AppBuildMode.beta:
        return "https://beta.truvideo.com";

      case AppBuildMode.rc:
        return "https://rc.truvideo.com";

      case AppBuildMode.prod:
        return "https://app.truvideo.com";
    }
  }

  static String getBaseEventLogsURL(AppBuildMode mode) {
    switch (mode) {
      case AppBuildMode.beta:
        return "https://event-logs-api-beta.truvideo.com";

      case AppBuildMode.rc:
        return "https://event-logs-api-rc.truvideo.com";

      case AppBuildMode.prod:
        return "https://event-logs-api.truvideo.com";
    }
  }

  static String getBaseMessagingURL(AppBuildMode mode) {
    switch (mode) {
      case AppBuildMode.beta:
        return "";

      case AppBuildMode.rc:
        return "";

      case AppBuildMode.prod:
        return "";
    }
  }

  static String getBaseChecklistURL(AppBuildMode mode) {
    switch (mode) {
      case AppBuildMode.beta:
        return "https://forms-beta.truvideo.com";

      case AppBuildMode.rc:
        return "https://forms-rc.truvideo.com";

      case AppBuildMode.prod:
        return "https://forms.truvideo.com";
    }
  }

  static String getBaseRepairOrderURL(AppBuildMode mode) {
    switch (mode) {
      case AppBuildMode.beta:
        return "https://order-api-beta.truvideo.com";

      case AppBuildMode.rc:
        return "https://order-api-rc.truvideo.com";

      case AppBuildMode.prod:
        return "https://order-api.truvideo.com";
    }
  }

  static String getBaseSupportURL(AppBuildMode mode) {
    switch (mode) {
      case AppBuildMode.beta:
        return "https://support-api-beta.truvideo.com";

      case AppBuildMode.rc:
        return "https://support-api-rc.truvideo.com";

      case AppBuildMode.prod:
        return "https://support-api.truvideo.com";
    }
  }

  static String getSecurityToken(AppBuildMode mode) {
    return "l1L0EkjJ1mmVNDGfQqT8";
  }

  static FirebaseOptions getFirebaseOptions(AppBuildMode mode) {
    switch (mode) {
      case AppBuildMode.beta:
        {
          if (Platform.isAndroid) return _firebaseOptionsBetaAndroid;
          if (Platform.isIOS) return _firebaseOptionsBetaIOS;
          throw CustomException();
        }

      case AppBuildMode.rc:
        {
          if (Platform.isAndroid) return _firebaseOptionsRCAndroid;
          if (Platform.isIOS) return _firebaseOptionsRCIOS;
          throw CustomException();
        }

      case AppBuildMode.prod:
        {
          if (Platform.isAndroid) return _firebaseOptionsProdAndroid;
          if (Platform.isIOS) return _firebaseOptionsProdIOS;
          throw CustomException();
        }
    }
  }

  //#region Beta

  static FirebaseOptions get _firebaseOptionsBetaAndroid => const FirebaseOptions(
        apiKey: 'AIzaSyBmMeWTyNUJQ-FRIoU-kyKForq-AI2dw4g',
        appId: '1:391143604655:android:8535a0d2a03feea2b7ef5a',
        messagingSenderId: '391143604655',
        projectId: 'truvideo---beta',
        storageBucket: 'truvideo---beta.appspot.com',
      );

  static FirebaseOptions get _firebaseOptionsBetaIOS => const FirebaseOptions(
        apiKey: 'AIzaSyCP_3EI3OEeEF4oagY-AqHOSFbnV2shcf8',
        appId: '1:391143604655:ios:228d0c581f5d3924b7ef5a',
        messagingSenderId: '391143604655',
        projectId: 'truvideo---beta',
        storageBucket: 'truvideo---beta.appspot.com',
        iosClientId: '391143604655-khsph4p76lkggi3lvk5u1fjqbpuldf8b.apps.googleusercontent.com',
        iosBundleId: 'com.truvideo.enterprise.beta',
      );

  //#endregion

  //#region RC

  static FirebaseOptions get _firebaseOptionsRCAndroid => const FirebaseOptions(
        apiKey: 'AIzaSyDk91_rmI1Dx83-WtSgNub1CAGVaWRXU1c',
        appId: '1:413279949394:android:73fc9c80bbc2bf597b458b',
        messagingSenderId: '413279949394',
        projectId: 'truvideo---rc',
        storageBucket: 'truvideo---rc.appspot.com',
      );

  static FirebaseOptions get _firebaseOptionsRCIOS => const FirebaseOptions(
        apiKey: 'AIzaSyBqSdtIIYlwC7ji_yN284-g_wSVteDBTEg',
        appId: '1:413279949394:ios:6e240133c79b1c967b458b',
        messagingSenderId: '413279949394',
        projectId: 'truvideo---rc',
        storageBucket: 'truvideo---rc.appspot.com',
        iosClientId: '413279949394-v8n19m46bvn3qscllgsk9ms5i7vm7cv4.apps.googleusercontent.com',
        iosBundleId: 'com.truvideo.enterprise.rc',
      );

  //#endregion

  //#region Prod

  static FirebaseOptions get _firebaseOptionsProdAndroid => const FirebaseOptions(
        apiKey: 'AIzaSyCEFBgP8pG_vy2tAzgSheulUQlrurq_GB8',
        appId: '1:616177256059:android:ede9daa46b9da4940884de',
        messagingSenderId: '616177256059',
        projectId: 'truvideo-production',
        storageBucket: 'truvideo-production.appspot.com',
      );

  static FirebaseOptions get _firebaseOptionsProdIOS => const FirebaseOptions(
        apiKey: 'AIzaSyBpY2_3nyp_M1ahv_mvZ4g1LgcOSZaQ0rU',
        appId: '1:616177256059:ios:1f962738f6c6a4820884de',
        messagingSenderId: '616177256059',
        projectId: 'truvideo-production',
        storageBucket: 'truvideo-production.appspot.com',
        iosClientId: '616177256059-8557jtribe666nhhnt1p680uiec6k43j.apps.googleusercontent.com',
        iosBundleId: 'com.truvideo.enterprise',
      );

//#endregion
}
