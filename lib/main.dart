import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_clean/core/themes/app_theme.dart';

import 'core/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quran App',
      initialRoute: '/home',
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
    );
  }
}
