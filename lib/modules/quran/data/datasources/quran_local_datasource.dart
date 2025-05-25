import 'package:flutter/services.dart' show rootBundle;
import 'package:get_storage/get_storage.dart';
import 'package:xml/xml.dart';

class QuranLocalDatasource {
  final savedAyat = GetStorage();

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
}
