abstract class LocalService {
  Future<void> storeBool(String key, bool value);

  bool readBool(String key, {bool defaultValue = false});

  Stream<bool> streamBool(String key, {bool defaultValue = false});

  Future<void> storeString(String key, String value);

  String readString(String key, {String defaultValue = ""});

  Stream<String> streamString(String key, {String defaultValue = ""});

  Future<void> delete(String key);
}
