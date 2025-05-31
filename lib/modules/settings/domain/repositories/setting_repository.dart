import '../models/setting.dart';

abstract class SettingRepository {
  Future<void> saveSetting(Setting setting);
  Future<Setting> getSetting();
}
