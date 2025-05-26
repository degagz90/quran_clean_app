import 'package:flutter/services.dart' show rootBundle;
import 'package:get_storage/get_storage.dart';
import 'package:xml/xml.dart';

class QuranLocalDatasource {
  Future<String> loadQuranJson() async {
    return await rootBundle.loadString('assets/jsons/quran.json');
  }

  Future<XmlDocument> loadQuranMeta() async {
    final String xmlString = await rootBundle.loadString(
      'assets/meta/quran_meta.xml',
    );
    final document = XmlDocument.parse(xmlString);
    return document;
  }

  Future<void> writeToStorage(String key, String value) async {
    final box = GetStorage();
    await box.write(key, value);
  }

  Future<String> readFromStorage(String key) async {
    final box = GetStorage();
    return await box.read(key);
  }
}
