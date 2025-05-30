import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/routes/app_pages.dart';
import 'core/themes/app_theme.dart';

void main() async {
  await initializeDateFormatting('id', null);
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quran App',
      initialRoute: '/',
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
    );
  }
}
