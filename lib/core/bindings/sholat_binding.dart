import 'package:get/get.dart';

import '../../modules/sholat/presentation/controllers/sholat_controller.dart';

class SholatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SholatController());
  }
}
