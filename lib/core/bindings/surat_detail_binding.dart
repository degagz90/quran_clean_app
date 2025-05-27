import 'package:get/get.dart';

import '../../modules/quran/presentation/controllers/quran_controller.dart';
import '../../modules/quran/presentation/controllers/surat_detail_controller.dart';

class SuratDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuranController());
    Get.lazyPut<SuratDetailController>(() => SuratDetailController());
  }
}
