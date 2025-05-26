import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/text_styles/app_text.dart';
import '../../controllers/quran_controller.dart';

class QuranLastReadCard extends StatelessWidget {
  const QuranLastReadCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuranController>();
    return SizedBox(
      height: 200,
      child: Center(
        child: Card(
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              Get.toNamed(
                '/surat_detail',
                arguments: {
                  'no_surat': controller.lastSuratNo.value,
                  'no_ayat': controller.lastAyatNo.value,
                },
              );
            },
            splashColor: Theme.of(context).primaryColor.withAlpha(150),
            child: Ink(
              padding: EdgeInsets.all(30),
              height: 180,
              width: Get.width - 30,
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage('assets/images/last_read.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lanjutkan Membaca:', style: AppText.titlePutihText2),
                  SizedBox(height: 20),
                  Obx(
                    () => Text(
                      'QS. ${controller.listSurat[(controller.lastSuratNo.value == 0 ? 1 : controller.lastSuratNo.value) - 1].name}',
                      style: AppText.titlePutihText,
                    ),
                  ),
                  Obx(
                    () => Text(
                      'Ayat ${(controller.lastAyatNo.value == 0 ? 1 : controller.lastAyatNo.value)}',
                      style: AppText.titlePutihText2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
