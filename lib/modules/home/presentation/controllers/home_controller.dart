import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  RxInt tabIndex = 0.obs;

  @override
  void onClose() {
    GetStorage().remove('location_cache');
    super.onClose();
  }
}
