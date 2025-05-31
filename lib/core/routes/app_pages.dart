import 'package:get/get.dart';

import '../../modules/bookmark/presentation/views/bookmark_view.dart';
import '../../modules/home/presentation/views/home_view.dart';
import '../../modules/quran/presentation/views/quran_view.dart';
import '../../modules/quran/presentation/views/surat_detail_view.dart';
import '../../modules/settings/presentation/views/settings_view.dart';
import '../../modules/sholat/presentation/views/sholat_view.dart';
import '../bindings/bookmark_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/quran_binding.dart';
import '../bindings/settings_binding.dart';
import '../bindings/sholat_binding.dart';
import '../bindings/surat_detail_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: AppRoutes.quran,
          page: () => QuranView(),
          binding: QuranBinding(),
        ),
        GetPage(
          name: AppRoutes.sholat,
          page: () => SholatView(),
          binding: SholatBinding(),
        ),
        GetPage(
          name: AppRoutes.bookmark,
          page: () => BookmarkView(),
          binding: BookmarkBinding(),
        ),
        GetPage(
          name: AppRoutes.settings,
          page: () => SettingsView(),
          binding: SettingsBinding(),
        ),
      ],
    ),
    GetPage(
      name: AppRoutes.suratDetail,
      page: () => SuratDetailView(),
      binding: SuratDetailBinding(),
    ),
  ];
}
