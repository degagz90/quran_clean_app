import '../../../settings/domain/models/setting.dart';
import '../../../settings/domain/usecases/get_setting.dart';

class GetAudioSetting {
  final GetSetting getSetting;
  GetAudioSetting(this.getSetting);

  Future<Setting> execute() async {
    return await getSetting.execute();
  }
}
