import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '_interface.dart';

class LocalServiceImpl implements LocalService {
  final StreamingSharedPreferences sharedPreferences;

  LocalServiceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<void> delete(String key) async {
    await sharedPreferences.remove(key);
  }

  @override
  bool readBool(String key, {bool defaultValue = false}) {
    return sharedPreferences.getBool(key, defaultValue: defaultValue).getValue();
  }

  @override
  Future<void> storeBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  @override
  String readString(String key, {String defaultValue = ""}) {
    return sharedPreferences.getString(key, defaultValue: defaultValue).getValue();
  }

  @override
  Future<void> storeString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  Stream<bool> streamBool(String key, {bool defaultValue = false}) {
    return sharedPreferences.getBool(key, defaultValue: defaultValue).asBroadcastStream();
  }

  @override
  Stream<String> streamString(String key, {String defaultValue = ""}) {
    return sharedPreferences.getString(key, defaultValue: defaultValue).asBroadcastStream();
  }
}
