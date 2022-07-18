abstract class LocalDatabaseService {
  Future<void> open(String name);

  Future<void> close(String name);

  Future<void> write(String boxName, String key, dynamic value);

  Future<dynamic> read(String boxName, String key);

  Future<List<dynamic>> getAll(String boxName);

  Future<List<String>> getAllKeys(String boxName);

  Stream<List<dynamic>> streamAll(String boxName);

  Stream<dynamic> streamByKey(String boxName, String key);

  Future<void> delete(String boxName, String key);

  Future<void> deleteAll(String boxName);
}
