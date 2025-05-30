import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/text_styles/app_text.dart';
import '../../controllers/surat_detail_controller.dart';

class SuratHeaderCard extends StatelessWidget {
  const SuratHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SuratDetailController>();
    return Card(
      color: Colors.grey[300],
      elevation: 10,
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: 320,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/card.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QS. ${controller.surat?.name ?? ''}',
              style: AppText.titlePutihText,
            ),
            Text(
              controller.surat?.arabName ?? '',
              style: AppText.arabPutihText,
            ),
            Text(
              controller.surat?.indoName ?? '',
              style: AppText.titlePutihText2,
            ),
            Text(
              '${controller.surat?.type ?? ''} - ${controller.surat?.jmlAyat ?? ''} ayat',
              style: AppText.titlePutihText2,
            ),
          ],
        ),
      ),
    );
  }
}
