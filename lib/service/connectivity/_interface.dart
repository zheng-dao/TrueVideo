abstract class ConnectivityService {
  Future<bool> isOnline();

  Future<bool> isOffline();

  Stream<bool> get onlineStream;

  Stream<bool> get offlineStream;

  Future<void> validateOnline();

  Future<String> networkType();

  Future<double> runBandwidthTest({
    Function(double speed, double percentage)? callback,
  });
}
