import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.ungu2,
    primaryColorDark: AppColors.ungu1,
    iconTheme: IconThemeData(color: AppColors.ungu2),
    fontFamily: 'Poppins',
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: AppColors.ungu2,
        fontSize: 20,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.ungu2),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(color: AppColors.ungu2, fontFamily: 'Poppins'),
      ),
      indicatorColor: AppColors.ungu2,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.ungu2,
    primaryColorDark: AppColors.ungu1,
    fontFamily: 'Poppins',
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: AppColors.ungu2,
        fontSize: 20,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.ungu2),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(color: AppColors.abu1, fontFamily: 'Poppins'),
      ),
    ),
  );
}
