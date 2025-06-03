import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          animationDuration: Duration(milliseconds: 500),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          elevation: 15,
          destinations: [
            NavigationDestination(
              selectedIcon: ImageIcon(
                AssetImage("assets/icons/quran.png"),
                size: 24,
                color: Colors.white,
              ),
              icon: ImageIcon(
                AssetImage("assets/icons/quran_outlined.png"),
                size: 24,
              ),
              label: 'Quran',
            ),
            NavigationDestination(
              selectedIcon: ImageIcon(
                AssetImage("assets/icons/sholat.png"),
                size: 24,
                color: Colors.white,
              ),
              icon: ImageIcon(
                AssetImage("assets/icons/sholat_outlined.png"),
                size: 24,
              ),
              label: 'Sholat',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark, color: Colors.white),
              icon: Icon(Icons.bookmark_border),
              label: 'Catatan',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings, color: Colors.white),
              icon: Icon(Icons.settings_outlined),
              label: 'Pengaturan',
            ),
          ],
          selectedIndex: controller.tabIndex.value,
          onDestinationSelected: (value) {
            controller.tabIndex.value = value;
            switch (value) {
              case 0:
                Get.rootDelegate.toNamed(AppRoutes.quran);
                break;
              case 1:
                Get.rootDelegate.toNamed(AppRoutes.sholat);
                break;
              case 2:
                Get.rootDelegate.toNamed(AppRoutes.bookmark);
                break;
              case 3:
                Get.rootDelegate.toNamed(AppRoutes.settings);
                break;
            }
          },
        ),
      ),
      body: GetRouterOutlet(
        initialRoute: AppRoutes.quran,
        anchorRoute: AppRoutes.home,
      ),
    );
  }
}
