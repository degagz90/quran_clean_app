import 'package:get/get.dart';
import 'package:quran_clean/modules/bookmark/presentation/controllers/bookmark_controller.dart';

import '../../modules/quran/presentation/controllers/quran_controller.dart';
import '../../modules/quran/presentation/controllers/surat_detail_controller.dart';

class SuratDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratDetailController>(() => SuratDetailController());
    Get.lazyPut(() => QuranController());
    Get.lazyPut(() => BookmarkController());
  }
}
