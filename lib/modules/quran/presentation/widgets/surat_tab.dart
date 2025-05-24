import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quran_controller.dart';

class SuratTab extends StatelessWidget {
  const SuratTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuranController>();
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: controller.listSurat.length,
      itemBuilder: (context, index) {
        final surah = controller.listSurat[index];
        return ListTile(
          leading: CircleAvatar(child: Text('${surah.noSurat}')),
          title: Text('${surah.name} (${surah.indoName})'),
          subtitle: Text('${surah.type} - ${surah.jmlAyat} ayat'),
          trailing: Text(surah.arabName, style: TextStyle(fontFamily: 'Amiri')),
        );
      },
    );
  }
}
