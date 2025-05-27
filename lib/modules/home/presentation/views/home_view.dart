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
          animationDuration: Duration(milliseconds: 800),
          shadowColor: Colors.purpleAccent,
          indicatorColor: Theme.of(context).primaryColor.withAlpha(100),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          elevation: 15,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Quran'),
            NavigationDestination(icon: Icon(Icons.bookmark), label: 'Catatan'),
          ],
          selectedIndex: controller.tabIndex.value,
          onDestinationSelected: (value) {
            controller.tabIndex.value = value;
            switch (value) {
              case 0:
                Get.rootDelegate.toNamed(AppRoutes.quran);
                break;
              case 1:
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
