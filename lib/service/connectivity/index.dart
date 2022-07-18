import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:speed_test_port/speed_test_port.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityServiceImpl extends ConnectivityService {
  final Connectivity _connectivity;

  //#region Initializers

  ConnectivityServiceImpl({Connectivity? connectivity}) : _connectivity = connectivity ?? Connectivity();

  //#endregion

  @override
  Future<bool> isOffline() async {
    return (await _connectivity.checkConnectivity()) == ConnectivityResult.none;
  }

  @override
  Future<bool> isOnline() async {
    return (await _connectivity.checkConnectivity()) != ConnectivityResult.none;
  }

  @override
  Stream<bool> get offlineStream => _connectivity.onConnectivityChanged.map((event) => event == ConnectivityResult.none);

  @override
  Stream<bool> get onlineStream => _connectivity.onConnectivityChanged.map((event) => event != ConnectivityResult.none);

  @override
  Future<void> validateOnline() async {
    final ConnectivityService connectivityService = GetIt.I.get();
    var isOffline = await connectivityService.isOffline();
    if (isOffline) {
      throw CustomException(message: "Must have an active internet connection");
    }
  }

  @override
  Future<String> networkType() async {
    String result = '';
    switch (await _connectivity.checkConnectivity()) {
      case ConnectivityResult.bluetooth:
        result = 'Bluetooth';
        break;
      case ConnectivityResult.ethernet:
        result = 'Ethernet';
        break;
      case ConnectivityResult.mobile:
        result = 'Mobile Data';
        break;
      case ConnectivityResult.none:
        result = 'None';
        break;
      case ConnectivityResult.wifi:
        result = 'Wifi';
        break;
      default:
    }
    return result;
  }

  @override
  Future<double> runBandwidthTest({
    Function(double speed, double percentage)? callback,
  }) async {
    final connected = await isOnline();
    if (!connected) {
      throw CustomException(message: "Not connected");
    }

    final tester = SpeedTest();

    //Getting closest servers
    var settings = await tester.GetSettings();

    var servers = settings.servers;
    if (servers.isEmpty) {
      throw CustomException(message: "Not available servers");
    }

    //Test latency for each server
    for (var server in servers) {
      server.Latency = await tester.TestServerLatency(server, 3);
    }

    //Getting best server
    servers.sort((a, b) => a.Latency.compareTo(b.Latency));
    var bestServer = servers.first;

    //Test download speed in MB/s
    var downloadSpeed = await tester.TestDownloadSpeed(
      bestServer,
      settings.download.ThreadsPerUrl == 0 ? 2 : settings.download.ThreadsPerUrl,
      3,
      callback: callback,
    );

    return downloadSpeed;
  }
}
