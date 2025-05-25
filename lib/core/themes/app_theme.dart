import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    tabBarTheme: TabBarThemeData(labelColor: AppColors.ungu1),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.biruTua1,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: 'Poppins',
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
        fontFamily: 'Poppins',
        fontSize: 20,
        color: AppColors.ungu1,
        fontWeight: FontWeight.bold,
      ),
    ),

    primaryColor: AppColors.ungu2,
    iconTheme: IconThemeData(color: AppColors.ungu2),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(iconColor: WidgetStateProperty.all(AppColors.ungu2)),
    ),
  );
}
