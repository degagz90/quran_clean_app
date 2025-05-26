import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/models/ayat.dart';
import '../../../controllers/surat_detail_controller.dart';

class PlayButton extends StatelessWidget {
  final Ayat ayat;
  final controller = Get.find<SuratDetailController>();
  PlayButton({required this.ayat});

  @override
  Widget build(BuildContext context) {
    final int index = ayat.noAyat - 1;
    return IconButton(
      onPressed: () async {
        // itemScrollC.scrollTo(index: index, duration: Duration(seconds: 1));
        if (controller.playingAyatIndex.value == index &&
            controller.isPlaying.value) {
          await controller.pausePlayAudio();
        } else {
          await controller.playAudioAyat(controller.noSurat.value, ayat.noAyat);
        }
      },
      icon: Obx(
        () => Icon(
          controller.playingAyatIndex.value == index &&
                  controller.isPlaying.value
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
  }
}
