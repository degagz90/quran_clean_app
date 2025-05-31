import 'package:get_storage/get_storage.dart';

class SholatLocalDatasource {
  final _cache = GetStorage();

  Future<void> writeCache(
    String key,
    Map<String, dynamic> value,
    Duration expduration,
  ) async {
    final duration = (DateTime.now().add(expduration).toIso8601String());
    await _cache.write(key, value);
    await _cache.write("expTime", duration);
  }

  Future<Map<String, dynamic>?> readCache(String key) async {
    final expTimeString = await _cache.read("expTime");
    if (expTimeString == null) {
      return null;
    }
    final expTime = DateTime.parse(expTimeString);
    if (DateTime.now().isAfter(expTime)) {
      await clearCache(key);
      return null;
    }
    return _cache.read(key);
  }

  Future<void> clearCache(String key) async {
    await _cache.remove("expTime");
    await _cache.remove(key);
  }
}
