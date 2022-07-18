import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  final routeStack = <Route<dynamic>>[];
  final Function(List<Route> routes)? onChange;

  CustomNavigatorObserver({this.onChange});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logNavigation(route.settings.name);
    routeStack.add(route);
    onChange?.call(routeStack);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (routeStack.isNotEmpty) {
      routeStack.removeLast();
      onChange?.call(routeStack);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (routeStack.isNotEmpty) {
      routeStack.removeLast();
      onChange?.call(routeStack);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _logNavigation(newRoute?.settings.name);
    if (routeStack.isNotEmpty) {
      routeStack.removeLast();
    }

    if (newRoute != null) {
      routeStack.add(newRoute);
    }
    onChange?.call(routeStack);
  }

  void _logNavigation(String? screenName) {
    LogEventService service = GetIt.I.get();
    screenName = screenName ?? "";
    screenName = screenName.replaceAll("/", "");
    screenName = screenName.trim();
    if (screenName.isEmpty) return;
    service.logScreen(screenName);
  }
}
