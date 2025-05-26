import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/models/ayat.dart';
import '../../../controllers/surat_detail_controller.dart';

class PlayButton extends StatelessWidget {
  final Ayat ayat;
  final controller = Get.find<SuratDetailController>();
  PlayButton({super.key, required this.ayat});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () async {}, icon: Icon(Icons.play_arrow));
  }
}
