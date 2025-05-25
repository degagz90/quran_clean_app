import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/text_styles/app_text.dart';
import '../controllers/surat_detail_controller.dart';

class AyatWidget extends StatelessWidget {
  const AyatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SuratDetailController>();
    final itemScrollC = ItemScrollController();
    final itemPosC = ItemPositionsListener.create();
    itemPosC.itemPositions.addListener(() {
      final positions = itemPosC.itemPositions.value;
      if (positions.isNotEmpty) {
        // Ambil ayat pertama yang terlihat di layar
        final firstVisible = positions
            .map((e) => e.index)
            .reduce((a, b) => a < b ? a : b);
        controller.lastReadAyat.value =
            controller.listAyat[firstVisible].noAyat;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller.noAyat.value != 0) {
        itemScrollC.jumpTo(index: controller.noAyat.value - 1);
      }
    });
    // print(itemPosC.itemPositions.value.first);
    return ScrollablePositionedList.separated(
      itemScrollController: itemScrollC,
      itemPositionsListener: itemPosC,
      itemBuilder: (context, index) {
        final ayat = controller.listAyat[index];
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.abu2.withAlpha(15),
              ),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    maxRadius: 15,
                    backgroundColor: AppColors.ungu2,
                    foregroundColor: Colors.white,
                    child: Text(
                      '${ayat.noAyat}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.play_arrow),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.bookmark_border),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                        TextButton.icon(
                          onPressed: () {
                            Get.defaultDialog(
                              barrierDismissible: false,
                              onCancel: () {},
                              textCancel: 'Tutup',
                              buttonColor: Theme.of(context).primaryColor,
                              titleStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              title:
                                  'Tafsir QS. ${controller.surat?.name}: ${ayat.noAyat}',
                              content: Flexible(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      '${ayat.tafsir}\n\nsumber: Aplikasi Quran Kementrian Agama Republik Indonesia',
                                      style: AppText.subtitleText,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          label: Text(
                            'tafsir',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          icon: Icon(Icons.arrow_right),
                          iconAlignment: IconAlignment.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            ListTile(
              title: Text(
                ayat.text,
                textAlign: TextAlign.right,
                style: AppText.arabBiruText,
              ),
              subtitle: Text(ayat.terjemah, style: AppText.subtitleText),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: controller.listAyat.length,
    );
  }
}
