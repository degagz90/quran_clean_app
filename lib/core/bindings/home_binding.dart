import 'package:get/get.dart';
import '../../modules/home/presentation/controllers/home_controller.dart';
import '../../modules/sholat/presentation/controllers/sholat_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
    // Get.put(SholatController(), permanent: true);
  }
}
