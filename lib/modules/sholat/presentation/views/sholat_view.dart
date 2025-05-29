import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_clean/modules/sholat/presentation/widgets/compass_widget.dart';

import '../controllers/sholat_controller.dart';
import '../widgets/prayer_time_widget.dart';
import '../widgets/time_card.dart';

class SholatView extends GetView<SholatController> {
  const SholatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sholat')),

      body: FutureBuilder(
        future: () async {
          await controller.getLocation();
          await controller.getQibla(controller.location.value!);
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsetsGeometry.all(12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TimeCard(),
                  Divider(height: 30),
                  PrayerTimeWidget(),
                  Divider(height: 30),
                  CompassWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
