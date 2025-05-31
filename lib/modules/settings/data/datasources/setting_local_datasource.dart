import 'package:get_storage/get_storage.dart';

class SettingLocalDatasource {
  final GetStorage box = GetStorage();

  Future<void> saveToStorage(String key, String value) async {
    await box.write(key, value);
  }

  Future<String?> readStorage(String key) async {
    return await box.read(key);
  }
}
