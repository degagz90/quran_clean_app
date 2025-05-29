import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_clean/core/utils/formater.dart';
import 'package:quran_clean/modules/sholat/presentation/controllers/sholat_controller.dart';

import '../../../../core/constants/text_styles/app_text.dart';

class TimeCard extends StatelessWidget {
  const TimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SholatController>();

    return Center(
      child: FutureBuilder(
        future: controller.getHijriDate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var tanggalHijriyah = controller.hijriDate.value;
          interval(
            controller.now,
            (callback) => controller.getHijriDate(),
            time: Duration(days: 1),
          );
          return Card(
            clipBehavior: Clip.hardEdge,
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/card.png'),
                  fit: BoxFit.cover,
                ),
              ),
              width: 360,
              height: 110,
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          Formater.hari(controller.now.value),
                          style: AppText.titlePutihText,
                        ),
                      ),
                      Divider(height: 5),
                      Obx(
                        () => Text(
                          Formater.tanggal(controller.now.value),
                          style: AppText.titlePutihText3,
                        ),
                      ),
                      Divider(height: 5),
                      Text(
                        "${tanggalHijriyah?.tanggal} ${tanggalHijriyah?.bulan} ${tanggalHijriyah?.tahun} H",
                        style: AppText.titlePutihText3,
                      ),
                    ],
                  ),
                  Obx(
                    () => Text(
                      Formater.jam(controller.now.value),
                      style: AppText.jamText,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
