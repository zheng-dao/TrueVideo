import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';

mixin ConnectivityMixin<T extends StatefulHookConsumerWidget> on State<T> {
  ConnectivityService get _connectivityService => GetIt.I.get();
  StreamSubscription? _subscription;

  Future<bool> get isOnline => _connectivityService.isOnline();

  Future<bool> get isOffline => _connectivityService.isOffline();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  _init() {
    _connectivityService.onlineStream.listen((event) {
      if (!mounted) return;
      onConnectivityChange(event);
    });
  }

  onConnectivityChange(bool online) {}
}
