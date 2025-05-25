import 'package:flutter/services.dart' show rootBundle;

class QuranLocalDatasource {
  Future<String> loadQuranJson() async {
    return await rootBundle.loadString('assets/jsons/quran.json');
  }
}
