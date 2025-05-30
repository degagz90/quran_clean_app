import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';
import 'package:quran_clean/core/constants/text_styles/app_text.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../controllers/sholat_controller.dart';

class CompassWidget extends StatefulWidget {
  const CompassWidget({super.key});

  @override
  CompassWidgetState createState() => CompassWidgetState();
}

class CompassWidgetState extends State<CompassWidget> {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16,
                  child: isFound
                      ? Text(
                          "Kiblat ditemukan!",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        )
                      : Text(
                          "mencari arah kiblat",
                          style: AppText.subtitleText,
                        ),
                ),
                SizedBox(height: 16, child: Icon(Icons.arrow_drop_down_sharp)),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: (heading) * (pi / 180) * -1,
                      child: Image.asset(
                        'assets/images/compass2.png', // pastikan file ini ada
                        width: 170,
                        height: 170,
                        color: AppColors.abu1,
                      ),
                    ),
                    Text(
                      " ${(heading < 0 ? heading + 360 : heading).toStringAsFixed(0)}°",
                      style: AppText.subtitleText,
                    ),
                  ],
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
