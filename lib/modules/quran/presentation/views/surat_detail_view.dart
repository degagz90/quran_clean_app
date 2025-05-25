import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/surat_detail_controller.dart';
import '../widgets/ayat_widget.dart';
import '../widgets/surat_header_card.dart';

class SuratDetailView extends GetView<SuratDetailController> {
  const SuratDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([controller.findSurat(), controller.getListAyat()]),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${controller.surat?.noSurat ?? ''}. ${controller.surat?.name ?? 'no data'}',
            ),
          ),
          body: SafeArea(
            minimum: EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(height: 200, child: SuratHeaderCard()),
                Expanded(child: AyatWidget()),
              ],
            ),
          ),
        );
      },
    );
  }
}
