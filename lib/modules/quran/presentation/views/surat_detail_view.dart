import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_clean/modules/quran/presentation/widgets/surat_detail/buttons/surat_search_button.dart';

import '../controllers/surat_detail_controller.dart';
import '../widgets/surat_detail/ayat_widget.dart';
import '../widgets/surat_detail/surat_header_card.dart';

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
            title: Obx(
              () => Text(
                '${controller.noSurat.value}. ${controller.surat?.name ?? 'no data'}',
              ),
            ),
            actions: [SuratSearchButton()],
          ),
          body: PageView.builder(
            itemCount: 114,
            reverse: true,
            controller: controller.pageC,
            onPageChanged: (value) async {
              await controller.stopMurottal();
              controller.resetPage();
              controller.noSurat.value = value + 1;
              await controller.findSurat();
              await controller.getListAyat();
              controller.update();
            },
            itemBuilder: (context, index) {
              return GetBuilder<SuratDetailController>(
                initState: (_) {},
                builder: (_) {
                  return SafeArea(
                    minimum: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        SizedBox(height: 160, child: SuratHeaderCard()),
                        Expanded(child: AyatWidget()),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
