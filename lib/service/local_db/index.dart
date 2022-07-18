import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';

class LocalDatabaseServiceImpl extends LocalDatabaseService {
  Future<Box> _box(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await open(boxName);
    }

    return Hive.box(boxName);
  }

  @override
  Future<void> close(String name) async {
    if (Hive.isBoxOpen(name)) {
      await Hive.box(name).close();
    }
  }

  @override
  Future<void> open(String name) async {
    if (!Hive.isBoxOpen(name)) {
      await Hive.openBox(name);
    }
  }

  @override
  Future<dynamic> read(String boxName, String key) async {
    final box = await _box(boxName);
    return box.get(key);
  }

  @override
  Future<void> write(String boxName, String key, value) async {
    final box = await _box(boxName);
    return box.put(key, value);
  }

  @override
  Future<List<dynamic>> getAll(String boxName) async {
    final box = await _box(boxName);
    return box.values.toList();
  }

  @override
  Stream<List<dynamic>> streamAll(String boxName) {
    StreamSubscription? streamSubscription;

    final streamController = StreamController<List<dynamic>>.broadcast(
      onCancel: () {
        streamSubscription?.cancel();
      },
    );

    _box(boxName).then((box) {
      streamController.add(box.values.toList());
      streamSubscription = box.watch().asBroadcastStream().listen((event) {
        streamController.add(box.values.toList());
      });
    });

    return streamController.stream;
  }

  @override
  Stream streamByKey(String boxName, String key) {
    StreamSubscription? streamSubscription;

    final streamController = StreamController<dynamic>.broadcast(
      onCancel: () {
        streamSubscription?.cancel();
      },
    );

    _box(boxName).then((box) {
      streamController.add(box.get(key));
      streamSubscription = box.watch(key: key).asBroadcastStream().listen((event) {
        streamController.add(event.value);
      });
    });

    return streamController.stream;
  }

  @override
  Future<void> delete(String boxName, String key) async {
    final box = await _box(boxName);
    await box.delete(key);
  }

  @override
  Future<void> deleteAll(String boxName) async {
    final box = await _box(boxName);
    await box.clear();
  }

  @override
  Future<List<String>> getAllKeys(String boxName) async {
    final box = await _box(boxName);
    return box.keys.map((e) => e.toString()).toList();
  }
}
