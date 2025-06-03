import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_clean/core/constants/text_styles/app_text.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../controllers/quran_controller.dart';

class SuratTab extends StatelessWidget {
  const SuratTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuranController>();
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: controller.listSurat.length,
      itemBuilder: (context, index) {
        final surat = controller.listSurat[index];
        return ListTile(
          onTap: () => Get.toNamed(
            AppRoutes.suratDetail,
            arguments: {'no_surat': surat.noSurat},
          ),
          leading: CircleAvatar(child: Text('${surat.noSurat}')),
          title: Text('${surat.name} (${surat.indoName})'),
          titleTextStyle: TextStyle(fontSize: 14, fontFamily: "Poppins"),
          subtitle: Text('${surat.type} - ${surat.jmlAyat} ayat'),
          trailing: Text(surat.arabName, style: AppText.arabUnguTrailing),
        );
      },
    );
  }
}
