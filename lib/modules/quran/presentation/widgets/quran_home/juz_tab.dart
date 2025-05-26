import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/quran_controller.dart';

class JuzTab extends StatelessWidget {
  const JuzTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuranController>();
    return ListView.separated(
      itemBuilder: (context, index) {
        final juz = controller.listJuz[index];
        return ListTile(
          onTap: () {
            Get.toNamed(
              "/surat_detail",
              arguments: {
                'no_surat': juz.startSuratNo,
                'no_ayat': juz.startAyatNo,
              },
            );
          },
          leading: CircleAvatar(child: Text('${juz.noJuz}')),
          title: Text('Juz ${juz.noJuz}'),
          subtitle: Text(
            'Mulai dari: QS. ${controller.listSurat[juz.startSuratNo - 1].name} ayat ${juz.startAyatNo}',
          ),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          iconColor: Theme.of(context).primaryColor,
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: controller.listJuz.length,
    );
  }
}
