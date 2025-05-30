import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_clean/core/constants/colors/app_colors.dart';

import 'package:quran_clean/core/routes/app_routes.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          animationDuration: Duration(milliseconds: 500),
          indicatorColor: AppColors.ungu2,
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(color: AppColors.ungu2, fontWeight: FontWeight.bold),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          elevation: 15,
          surfaceTintColor: Colors.white,
          destinations: [
            NavigationDestination(
              selectedIcon: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(
                  "assets/icons/quran.png",
                  color: Colors.white,
                ),
              ),
              icon: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(
                  "assets/icons/quran_outlined.png",
                  color: AppColors.ungu2,
                ),
              ),
              label: 'Quran',
            ),
            NavigationDestination(
              selectedIcon: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(
                  "assets/icons/sholat.png",
                  color: Colors.white,
                ),
              ),
              icon: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(
                  "assets/icons/sholat_outlined.png",
                  color: AppColors.ungu2,
                ),
              ),
              label: 'Sholat',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark, color: Colors.white),
              icon: Icon(Icons.bookmark_border, color: AppColors.ungu2),
              label: 'Catatan',
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
