import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'core/routes/app_pages.dart';
import 'core/themes/app_theme.dart';
import 'modules/notification/data/datasources/local_notifications_datasource.dart';
import 'modules/settings/domain/models/setting.dart';

final NotificationService notification = NotificationService();
final box = GetStorage();
final String? data = box.read("setting");
final Map<String, dynamic>? settingStr = data != null
    ? jsonDecode(data!)
    : null;
final Tema tema = settingStr != null && settingStr?["tema"] != null
    ? Tema.values.firstWhere((element) => element.name == settingStr?["tema"])
    : Tema.light;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await notification.initialize();
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
      darkTheme: AppTheme.darkTheme,
      themeMode: tema == Tema.dark ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
