import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_clean/modules/quran/presentation/widgets/last_read_card.dart';
import 'package:quran_clean/modules/quran/presentation/widgets/surat_tab.dart';

import '../controllers/quran_controller.dart';

class QuranView extends GetView<QuranController> {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text('Quran Clean App')),
        body: FutureBuilder(
          future: controller.loadSuratList(),
          builder: (context, snapsot) {
            if (snapsot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  QuranLastReadCard(),
                  TabBar(
                    tabs: [
                      Tab(text: 'Surat'),
                      Tab(text: 'Juz'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(children: [SuratTab(), Text('tab 2')]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
