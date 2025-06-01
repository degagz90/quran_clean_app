import '../../../settings/domain/models/setting.dart';
import '../../../settings/domain/usecases/get_setting.dart';

class GetSholatSetting {
  final GetSetting getSetting;
  GetSholatSetting(this.getSetting);

  Future<Setting> execute() async {
    return await getSetting.execute();
  }
}
