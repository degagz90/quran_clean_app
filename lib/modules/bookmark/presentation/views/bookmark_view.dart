import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/text_styles/app_text.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/formater.dart';
import '../../domain/model/bookmark.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catatan')),

      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text('Total Catatan: ${controller.bookmarks.length}')),
            SizedBox(height: 8),
            Text(
              "(ketuk untuk melihat detail)",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: controller.bookmarks.length,
                  itemBuilder: (context, index) {
                    Bookmark bookmark = controller.bookmarks[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(
                        'QS. ${bookmark.suratName} ayat ${bookmark.noAyat}',
                      ),
                      subtitle: Text(bookmark.timeStamp),
                      onTap: () {
                        final timeStamp = Formater.timeStamp(DateTime.now());
                        controller.textC.text = bookmark.catatan;
                        Get.defaultDialog(
                          buttonColor: Theme.of(context).primaryColor,
                          textConfirm: 'edit',
                          textCancel: 'hapus',
                          barrierDismissible: true,
                          onConfirm: () async {
                            bookmark.catatan = controller.textC.text;
                            bookmark.timeStamp = timeStamp;
                            await controller.editBookmark(bookmark);
                            Get.back(canPop: false);
                          },
                          onCancel: () async {
                            await controller.deleteBookmark(bookmark);
                          },
                          title:
                              "QS. ${bookmark.suratName}: ${bookmark.noAyat}",
                          titleStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(timeStamp, style: AppText.subtitleText),
                              Divider(),
                              Text(
                                'Tambahkan Catatan:',
                                style: AppText.subtitleText,
                              ),
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
                      trailing: FilledButton(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.suratDetail,
                            arguments: {
                              "no_surat": bookmark.noSurat,
                              "no_ayat": bookmark.noAyat,
                            },
                          );
                        },
                        child: Text("Ke Ayat"),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
