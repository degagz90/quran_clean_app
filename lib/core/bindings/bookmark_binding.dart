import 'package:get/get.dart';

import '../../modules/bookmark/presentation/controllers/bookmark_controller.dart';

class BookmarkBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookmarkController>(() => BookmarkController());
  }
}
