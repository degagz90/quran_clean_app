import 'package:get/get.dart';

import '../../modules/quran/presentation/controllers/quran_controller.dart';

class QuranBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuranController());
  }
}
