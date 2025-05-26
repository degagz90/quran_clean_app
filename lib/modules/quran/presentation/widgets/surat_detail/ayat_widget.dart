import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../core/constants/colors/app_colors.dart';
import '../../../../../core/constants/text_styles/app_text.dart';
import '../../controllers/surat_detail_controller.dart';
import 'ayat_widget_buttons/play_button.dart';
import 'ayat_widget_buttons/tafsir_button.dart';

class AyatWidget extends StatelessWidget {
  const AyatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SuratDetailController>();
    final itemScrollC = ItemScrollController();
    final itemPosC = ItemPositionsListener.create();
    itemPosC.itemPositions.addListener(() {
      final positions = itemPosC.itemPositions.value;
      controller.findLastRead(positions);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller.noAyat.value != 0) {
        itemScrollC.jumpTo(index: controller.noAyat.value - 1);
      }
    });
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
                        PlayButton(ayat: ayat),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.bookmark_border),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                        TafsirButton(controller.surat!, ayat),
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
