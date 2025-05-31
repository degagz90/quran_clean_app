import '../models/setting.dart';
import '../repositories/setting_repository.dart';

class SaveSetting {
  final SettingRepository repository;
  SaveSetting(this.repository);

  Future<void> execute(Setting setting) async {
    await repository.saveSetting(setting);
  }
}
