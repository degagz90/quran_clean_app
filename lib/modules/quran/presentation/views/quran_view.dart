import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quran_controller.dart';
import '../widgets/quran_home/juz_tab.dart';
import '../widgets/quran_home/last_read_card.dart';
import '../widgets/quran_home/surat_tab.dart';

class QuranView extends GetView<QuranController> {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text('Quran Clean App')),
        body: FutureBuilder(
          future: Future.wait([
            controller.loadSuratList(),
            controller.loadJuzList(),
          ]),
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
                  Expanded(child: TabBarView(children: [SuratTab(), JuzTab()])),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
