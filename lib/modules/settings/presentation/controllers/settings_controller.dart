import 'package:get/get.dart';
import 'package:quran_clean/modules/sholat/presentation/controllers/sholat_controller.dart';

import '../../data/repositories/setting_repository_impl.dart';
import '../../domain/models/setting.dart';
import '../../domain/usecases/get_setting.dart';
import '../../domain/usecases/save_setting.dart';

class SettingsController extends GetxController {
  final sholatController = Get.find<SholatController>();
  final repository = SettingRepositoryImpl();
  Rx<Tema> selectedTema = Tema.light.obs;
  Rx<Qari> selectedQari = Qari.alAfasy.obs;
  Rx<bool> continuesPlay = false.obs;
  Rx<bool> playAdzan = false.obs;

  @override
  void onInit() {
    // ambil setting/default saat init
    getSetting();
    super.onInit();
    ever(playAdzan, (callback) {
      if (playAdzan.value) {
        sholatController.setAdzanNotif();
      } else {
        sholatController.deleteAdzanNotif();
      }
    });
  }

  @override
  void onClose() {
    // simpan setting saat close
    saveSetting();
    super.onClose();
  }

  Future<void> getSetting() async {
    //ambil setting dari database
    final useCase = GetSetting(repository);
    Setting setting = await useCase.execute();
    //ubah nilai var berdasarkan setting
    selectedTema.value = setting.tema;
    selectedQari.value = setting.qari;
    continuesPlay.value = setting.continuesPlay;
    playAdzan.value = setting.playAdzan;
  }

  Future<void> saveSetting() async {
    final useCase = SaveSetting(repository);
    //jadikan var ke bentuk object Setting
    final setting = Setting(
      tema: selectedTema.value,
      qari: selectedQari.value,
      continuesPlay: continuesPlay.value,
      playAdzan: playAdzan.value,
    );
    //simpan setting ke database
    await useCase.execute(setting);
  }
}
