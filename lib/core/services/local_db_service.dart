import 'package:hive/hive.dart';

class LocalDBService {
  Future<void> init<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<T>(boxName);
    }
  }

  Future<void> save<T>(String boxName, String key, T value) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  Future<void> saveAll<T>(String boxName, List<T> values) async {
    final box = Hive.box<T>(boxName);
    await box.clear();
    await box.addAll(values);
  }

  List<T> getAll<T>(String boxName) {
    final box = Hive.box<T>(boxName);
    return box.values.toList();
  }

  T? get<T>(String boxName, String key) {
    final box = Hive.box<T>(boxName);
    return box.get(key);
  }

  Future<void> delete<T>(String boxName, String key) async {
    final box = Hive.box<T>(boxName);
    await box.delete(key);
  }

  Future<void> clear<T>(String boxName) async {
    final box = Hive.box<T>(boxName);
    await box.clear();
  }
}
