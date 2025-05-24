import 'package:flutter/services.dart' show rootBundle;

class QuranLocalDatasource {
  Future<String> loadQuranJson() async {
    return await rootBundle.loadString('lib/core/assets/jsons/quran.json');
  }
}
