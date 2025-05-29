import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sholat_controller.dart';
import '../widgets/prayer_time_widget.dart';
import '../widgets/time_card.dart';

class SholatView extends GetView<SholatController> {
  const SholatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sholat')),

      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TimeCard(),
              Divider(height: 30),
              PrayerTimeWidget(),
              Divider(height: 30),
              Text("Arah Kiblat"),
            ],
          ),
        ),
      ),
    );
  }
}
