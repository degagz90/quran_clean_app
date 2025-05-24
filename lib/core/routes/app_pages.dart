import 'package:get/get.dart';

import '../../modules/home/presentation/views/home_view.dart';
import '../../modules/quran/presentation/views/quran_view.dart';
import '../bindings/home_binding.dart';
import '../bindings/quran_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
      children: [],
    ),
    GetPage(
      name: AppRoutes.quran,
      page: () => QuranView(),
      binding: QuranBinding(),
    ),
  ];
}
