import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../core/constants/colors/app_colors.dart';
import '../../../../../core/constants/text_styles/app_text.dart';
import '../../controllers/surat_detail_controller.dart';
import 'buttons/bookmark_button.dart';
import 'buttons/play_button.dart';
import 'buttons/tafsir_button.dart';

class AyatWidget extends StatefulWidget {
  const AyatWidget({super.key});

  @override
  State<AyatWidget> createState() => _AyatWidgetState();
}

class _AyatWidgetState extends State<AyatWidget> {
  final controller = Get.find<SuratDetailController>();
  final itemScrollC = ItemScrollController();
  final itemPosC = ItemPositionsListener.create();
  late Worker _scrollWorker;
  late Worker _scrollWorker2;

  @override
  void initState() {
    super.initState();
    _scrollWorker = ever(controller.playingAyatIndex, (int index) {
      if (index >= 0) {
        itemScrollC.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      }
    });
    _scrollWorker2 = ever(controller.searchedAyatIndex, (int index) {
      if (index >= 0) {
        itemScrollC.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      }
    });
    itemPosC.itemPositions.addListener(() {
      final positions = itemPosC.itemPositions.value;
      controller.findLastRead(positions);
    });
  }

  @override
  void dispose() {
    _scrollWorker.dispose();
    _scrollWorker2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        final surat = controller.surat!;
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.theme.brightness == Brightness.light
                    ? AppColors.abu2.withAlpha(15)
                    : AppColors.biruTua3,
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
                        BookmarkButton(surat: surat, ayat: ayat),
                        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                        TafsirButton(surat, ayat),
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
                style: Get.theme.brightness == Brightness.light
                    ? AppText.arabBiruText
                    : AppText.arabPutihText,
              ),
              subtitle: Text(
                ayat.terjemah,
                style: Get.theme.brightness == Brightness.light
                    ? AppText.listTileSubtLight
                    : AppText.listTileSubtDark,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: controller.listAyat.length,
    );
  }
}
