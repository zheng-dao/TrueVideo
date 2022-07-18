import 'package:flutter/material.dart';

class ScreenHomeController extends ChangeNotifier {
  String _appBarTitle = "";
  List<Widget> _appBarActions = <Widget>[];
  Widget? _fab;
  Future<bool> Function()? _onWillPop;

  String get appBarTitle => _appBarTitle;

  List<Widget> get appBarActions => _appBarActions;

  Widget? get fab => _fab;

  Future<bool> Function()? get onWillPop => _onWillPop;

  set appBarTitle(String value) {
    if (_appBarTitle == value) return;

    _appBarTitle = value;
    notifyListeners();
  }

  set appBarActions(List<Widget> value) {
    if (_appBarActions == value) return;

    _appBarActions = value;
    notifyListeners();
  }

  set fab(Widget? value) {
    if (_fab == value) return;

    _fab = value;
    notifyListeners();
  }

  set onWillPop(Future<bool> Function()? value) {
    if (_onWillPop == value) return;

    _onWillPop = value;
    notifyListeners();
  }

  void clear() {
    _appBarTitle = "";
    _appBarActions = [];
    _fab = null;
    _onWillPop = null;
    notifyListeners();
  }
}
