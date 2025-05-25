import 'package:get/get.dart';

import '../../modules/quran/presentation/controllers/surat_detail_controller.dart';

class SuratDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratDetailController>(() => SuratDetailController());
  }
}
