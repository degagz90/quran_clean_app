import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quran_controller.dart';

class QuranView extends GetView<QuranController> {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quran Clean App')),
      body: FutureBuilder(
        future: controller.loadSuratList(),
        builder: (context, snapsot) {
          if (snapsot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 200, child: Placeholder()),
                SizedBox(height: 40, child: Placeholder()),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: controller.listSurat.length,
                    itemBuilder: (context, index) {
                      final surah = controller.listSurat[index];
                      return ListTile(
                        leading: CircleAvatar(child: Text('${surah.noSurat}')),
                        title: Text('${surah.name} (${surah.indoName})'),
                        subtitle: Text('${surah.type} - ${surah.jmlAyat} ayat'),
                        trailing: Text('${surah.arabName}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
