import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/constants/text_styles/app_text.dart';
import '../../../../../../core/utils/formater.dart';
import '../../../../domain/models/ayat.dart';
import '../../../../domain/models/surat.dart';

class BookmarkButton extends StatelessWidget {
  final Surat surat;
  final Ayat ayat;
  const BookmarkButton({required this.surat, required this.ayat, super.key});

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
          onConfirm: () {},
          onCancel: () {},
          title: "QS. ${surat.name}: ${ayat.noAyat}",
          titleStyle: TextStyle(color: Theme.of(context).primaryColor),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(timeStamp, style: AppText.subtitleText),
              Divider(),
              Text('Tambahkan Catatan:', style: AppText.subtitleText),
              TextField(),
            ],
          ),
        );
      },
      icon: Icon(Icons.bookmark_border),
    );
  }
}
