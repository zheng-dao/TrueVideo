import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BackButtonExitMixin {
  bool _askClose = true;

  bool onButtonBackPressed() {
    if (_askClose) {
      _askClose = false;
      Future.delayed(const Duration(seconds: 5)).then((value) => _askClose = true);
      Fluttertoast.showToast(msg: "Press back again to close de app");
      return false;
    }

    SystemNavigator.pop();
    return true;
  }
}
