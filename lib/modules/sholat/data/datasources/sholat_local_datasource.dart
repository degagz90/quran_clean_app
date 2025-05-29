import 'package:get_storage/get_storage.dart';

class SholatLocalDatasource {
  final box = GetStorage();

  Future<void> writeBox(String key, Map<String, dynamic> value) async {
    await box.write(key, value);
  }

  Future<Map<String, dynamic>> readBox(String key) async {
    return await box.read(key);
  }

  Future<bool> hasData(String key) async {
    return await box.hasData(key);
  }
}
