import 'package:get_storage/get_storage.dart';

/// Simple wrapper around [GetStorage].
class LocalStore {
  LocalStore(this._box);

  final GetStorage _box;

  static Future<LocalStore> init() async {
    await GetStorage.init();
    return LocalStore(GetStorage());
  }

  T? read<T>(String key) => _box.read<T>(key);
  Future<void> write(String key, dynamic value) => _box.write(key, value);
  Future<void> remove(String key) => _box.remove(key);
}
