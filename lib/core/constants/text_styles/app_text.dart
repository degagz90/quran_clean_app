import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class AppText {
  static const arabBiruText = TextStyle(
    fontFamily: 'Quran Kemenag',
    fontWeight: FontWeight.w500,
    fontSize: 24,
    color: AppColors.biruTua1,
  );

  static const arabPutihText = TextStyle(
    fontFamily: 'Quran Kemenag',
    fontWeight: FontWeight.w500,
    fontSize: 30,
    color: Color(0xFFFFFFFF),
  );

  static const titlePutihText = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Color(0xFFFFFFFF),
  );

  static const titlePutihText2 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Color(0xFFFFFFFF),
  );

  static const subtitleText = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Color(0xFF616161),
  );
}
