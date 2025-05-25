import 'package:flutter/services.dart' show rootBundle;
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
}
