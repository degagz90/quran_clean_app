import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_clean/core/constants/colors/app_colors.dart';
import 'package:quran_clean/modules/settings/domain/models/setting.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan')),

      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pengaturan Tema"),
              ListTile(
                title: Text('Tema:'),
                trailing: Obx(
                  () => SegmentedButton(
                    segments: [
                      ButtonSegment(
                        value: Tema.light,
                        icon: Icon(Icons.light_mode),
                      ),
                      ButtonSegment(
                        value: Tema.dark,
                        icon: Icon(Icons.dark_mode),
                      ),
                    ],
                    selected: {controller.selectedTema.value},
                    onSelectionChanged: (Set<Tema> newSelection) {
                      controller.selectedTema.value = newSelection.first;
                      controller.toogleTheme();
                      controller.saveSetting();
                    },
                  ),
                ),
              ),
              Divider(),
              Text("Pengaturan Audio Quran"),
              ListTile(
                title: Text('Qari:'),
                trailing: Obx(
                  () => DropdownButton(
                    value: controller.selectedQari.value,
                    items: [
                      DropdownMenuItem(
                        value: Qari.alAfasy,
                        child: Text('Misari Rashid al-Afasy'),
                      ),
                      DropdownMenuItem(
                        value: Qari.ashShatree,
                        child: Text('Abu Bakr Ash-Shaatree'),
                      ),
                      DropdownMenuItem(
                        value: Qari.haniRifai,
                        child: Text("Hani Ar-Rifa'i"),
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectedQari.value =
                          value ?? controller.selectedQari.value;
                      controller.saveSetting();
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text("Izinkan pemutaran berkelanjutan:"),
                trailing: Obx(
                  () => Switch(
                    activeColor: AppColors.ungu2,
                    value: controller.continuesPlay.value,
                    onChanged: (value) {
                      controller.continuesPlay.value = value;
                      controller.saveSetting();
                    },
                  ),
                ),
              ),
              Divider(),
              Text("Pengaturan Notifikasi"),
              ListTile(
                title: Text("Izinkan notifikasi adzan:"),
                trailing: Obx(
                  () => Switch(
                    activeColor: AppColors.ungu2,
                    value: controller.playAdzan.value,
                    onChanged: (value) async {
                      controller.playAdzan.value = value;
                      controller.saveSetting();
                    },
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
