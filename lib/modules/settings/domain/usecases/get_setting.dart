import '../models/setting.dart';
import '../repositories/setting_repository.dart';

class GetSetting {
  final SettingRepository repository;
  GetSetting(this.repository);

  Future<Setting> execute() async {
    return await repository.getSetting();
  }
}
