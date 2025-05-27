import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_clean/modules/quran/presentation/controllers/surat_detail_controller.dart';

import '../../../../../../core/constants/text_styles/app_text.dart';
import '../../../../../../core/utils/formater.dart';
import '../../../../domain/models/ayat.dart';
import '../../../../domain/models/surat.dart';

class BookmarkButton extends StatelessWidget {
  final Surat surat;
  final Ayat ayat;
  final controller = Get.find<SuratDetailController>();
  BookmarkButton({required this.surat, required this.ayat, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final timeStamp = Formater.timeStamp(DateTime.now());
        Get.defaultDialog(
          buttonColor: Theme.of(context).primaryColor,
          textConfirm: 'add',
          textCancel: 'cancel',
          barrierDismissible: false,
          onConfirm: () {
            controller.addBookmark(
              surat.name,
              surat.noSurat,
              ayat.noAyat,
              controller.textC.text,
              timeStamp,
            );
            controller.textC.text = '';
            Get.back(canPop: false);
          },
          onCancel: () {},
          title: "QS. ${surat.name}: ${ayat.noAyat}",
          titleStyle: TextStyle(color: Theme.of(context).primaryColor),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(timeStamp, style: AppText.subtitleText),
              Divider(),
              Text('Tambahkan Catatan:', style: AppText.subtitleText),
              TextField(
                controller: controller.textC,
                autocorrect: false,
                autofocus: true,
                minLines: 1,
                maxLines: 10,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: 'mulai mengetik',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      },
      icon: Icon(Icons.bookmark_border),
    );
  }
}
