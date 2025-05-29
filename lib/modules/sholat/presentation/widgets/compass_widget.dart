import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';
import 'package:quran_clean/core/constants/text_styles/app_text.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../controllers/sholat_controller.dart';

class CompassWidget extends StatefulWidget {
  @override
  _CompassWidgetState createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SholatController>();
    return Center(
      child: StreamBuilder<double>(
        stream: FlutterCompass.events
            ?.map((event) => event.heading)
            .where((heading) => heading != null)
            .cast<double>(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double? heading = snapshot.data;
            bool isFound = (heading! - controller.arahKiblat).abs() < 2;
            return Column(
              children: [
                Text(
                  isFound ? "Kiblat ditemukan!!" : "mencari arah kiblat..",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Transform.rotate(
                  angle: (heading) * (pi / 180) * -1,
                  child: Image.asset(
                    'assets/images/compass.png', // pastikan file ini ada
                    width: 160,
                    height: 160,
                    color: AppColors.ungu1,
                  ),
                ),
                Text(
                  "heading: ${heading.toStringAsFixed(1)}°",
                  style: AppText.subtitleText,
                ),
              ],
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}
