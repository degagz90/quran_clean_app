import 'package:get/get.dart';
import 'package:quran_clean/modules/home/presentation/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }
}
