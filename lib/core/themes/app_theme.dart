import 'package:flutter/material.dart';
import 'package:quran_clean/core/constants/text_styles/app_text.dart';

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
      iconTheme: WidgetStatePropertyAll(IconThemeData(color: AppColors.ungu2)),
    ),

    listTileTheme: ListTileThemeData(
      titleTextStyle: AppText.listTileTitleLight,
      subtitleTextStyle: AppText.listTileSubtLight,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.ungu2,
    primaryColorDark: AppColors.ungu1,
    scaffoldBackgroundColor: AppColors.biruTua2,
    fontFamily: 'Poppins',

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.biruTua2,
      titleTextStyle: TextStyle(
        color: AppColors.ungu2,
        fontSize: 20,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.ungu2),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.biruTua3,
      labelTextStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(color: AppColors.abu1, fontFamily: 'Poppins'),
      ),
      iconTheme: WidgetStatePropertyAll(IconThemeData(color: AppColors.abu1)),
    ),

    listTileTheme: ListTileThemeData(
      subtitleTextStyle: AppText.listTileSubtDark,
    ),
  );
}
