import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_clean/core/constants/colors/app_colors.dart';
import 'package:quran_clean/modules/quran/presentation/controllers/surat_detail_controller.dart';

import '../../../../../../core/constants/text_styles/app_text.dart';
import '../../../../../../core/utils/formater.dart';
import '../../../../domain/models/ayat.dart';
import '../../../../domain/models/surat.dart';

class BookmarkButton extends StatefulWidget {
  final Surat surat;
  final Ayat ayat;
  const BookmarkButton({required this.surat, required this.ayat, super.key});

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  final controller = Get.find<SuratDetailController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.isBookmarked(widget.surat.noSurat, widget.ayat.noAyat),
      builder: (context, snapshot) {
        final isBookmarked = snapshot.data ?? false;
        return IconButton(
          onPressed: () async {
            final timeStamp = Formater.timeStamp(DateTime.now());
            if (isBookmarked) {
              var bookmark = await controller.findBookmark(
                widget.surat.noSurat,
                widget.ayat.noAyat,
              );
              controller.textEditC.text = bookmark.catatan;
              Get.defaultDialog(
                buttonColor: AppColors.ungu2,
                textConfirm: 'edit',
                textCancel: 'hapus',
                barrierDismissible: true,
                onConfirm: () async {
                  bookmark.catatan = controller.textEditC.text;
                  bookmark.timeStamp = timeStamp;
                  await controller.editBookmark(bookmark);
                  Get.back(canPop: false);
                },
                onCancel: () async {
                  await controller.deleteBookmark(bookmark);
                },
                title: "QS. ${bookmark.suratName}: ${bookmark.noAyat}",
                titleStyle: TextStyle(color: AppColors.ungu2),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(timeStamp, style: AppText.subtitleText),
                    Divider(),
                    Text('Tambahkan Catatan:', style: AppText.subtitleText),
                    TextField(
                      controller: controller.textEditC,
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
            } else {
              Get.defaultDialog(
                buttonColor: Theme.of(context).primaryColor,
                textConfirm: 'tambah',
                barrierDismissible: true,
                onConfirm: () async {
                  Get.back(canPop: false);
                  await controller.addBookmark(
                    widget.surat.name,
                    widget.surat.noSurat,
                    widget.ayat.noAyat,
                    controller.textAddC.text,
                    timeStamp,
                  );
                  controller.textAddC.text = '';
                },
                title: "QS. ${widget.surat.name}: ${widget.ayat.noAyat}",
                titleStyle: TextStyle(color: Theme.of(context).primaryColor),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(timeStamp, style: AppText.subtitleText),
                    Divider(),
                    Text('Tambahkan Catatan:', style: AppText.subtitleText),
                    TextField(
                      controller: controller.textAddC,
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
            }
            setState(() {});
          },
          icon: Icon(
            isBookmarked ? Icons.bookmark_added : Icons.bookmark_border,
          ),
        );
      },
    );
  }
}
