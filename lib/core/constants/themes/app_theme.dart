import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    tabBarTheme: TabBarThemeData(labelColor: AppColors.ungu1),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.biruTua1,
      ),
      subtitleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: AppColors.abu1,
      ),
      leadingAndTrailingTextStyle: TextStyle(
        fontFamily: 'Amiri',
        color: AppColors.ungu2,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: AppColors.ungu1,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
