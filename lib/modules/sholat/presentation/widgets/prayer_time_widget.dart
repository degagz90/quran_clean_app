import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_clean/core/utils/formater.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/divider/paddings.dart';
import '../controllers/sholat_controller.dart';

class PrayerTimeWidget extends StatelessWidget {
  const PrayerTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SholatController>();

    return FutureBuilder(
      future: Future.wait([
        controller.getLocation(),
        controller.getWaktuSholat(),
      ]),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.location.value == null &&
            controller.waktuSholat.value == null) {
          return Center(child: Text('tidak ada data'));
        }
        var currentLocation = controller.location.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.place, color: AppColors.ungu2),
                SizedBox(width: 10),
                Text(
                  "${currentLocation?.cityName}, ${currentLocation?.countryName}",
                ),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text('Jadwal sholat hari ini:'),
            ),
            SizedBox(height: 5),
            Table(
              border: TableBorder.all(
                color: AppColors.ungu2,
                borderRadius: BorderRadius.circular(10),
                width: 3,
              ),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text("Subuh"),
                    ),
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text(
                        Formater.jam(controller.waktuSholat.value!.subuhTime),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text("Terbit"),
                    ),
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text(
                        Formater.jam(controller.waktuSholat.value!.terbitTime),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text("Dzuhur"),
                    ),
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text(
                        Formater.jam(controller.waktuSholat.value!.dzuhurTime),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text("Ashar"),
                    ),
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text(
                        Formater.jam(controller.waktuSholat.value!.asharTime),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text("Maghrib"),
                    ),
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text(
                        Formater.jam(controller.waktuSholat.value!.maghribTime),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text("Isya"),
                    ),
                    Padding(
                      padding: AppPaddings.tablePadding,
                      child: Text(
                        Formater.jam(controller.waktuSholat.value!.isyaTime),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'Berikutnya: ${controller.waktuSholat.value!.nextPrayer} dalam ${Formater.jam(controller.waktuSholat.value!.nextPrayerTime)}',
            ),
          ],
        );
      },
    );
  }
}
