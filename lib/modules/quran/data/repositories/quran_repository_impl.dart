import 'dart:convert';

import '../datasources/quran_local_datasource.dart';
import '../../domain/models/ayat.dart';
import '../../domain/models/surat.dart';
import '../../domain/repositories/quran_repository.dart';

class QuranRepositoryImpl implements QuranRepository {
  final localData = QuranLocalDatasource();

  @override
  Future<Ayat> findAyat(int noSurat, int noAyat) {
    // TODO: implement findAyat
    throw UnimplementedError();
  }

  @override
  Future<Surat> findSurat(int noSurat) async {
    final quranJson = await localData.loadQuranJson();
    final List<dynamic> surats = jsonDecode(quranJson);
    final surat = surats[noSurat - 1];
    return Surat(
      name: surat['name'],
      arabName: surat['name_translations']['ar'],
      indoName: surat['name_translations']['id'],
      type: surat['type'],
      noSurat: surat['number_of_surah'],
      jmlAyat: surat['number_of_ayah'],
    );
  }

  @override
  Future<List<Ayat>> getListAyat(int noSurat) async {
    final quranJson = await localData.loadQuranJson();
    final List<dynamic> surats = jsonDecode(quranJson);
    final List<dynamic> ayats = surats[noSurat - 1]['verses'];
    return ayats.map<Ayat>((element) {
      return Ayat(
        noSurat: noSurat,
        noAyat: element['number'],
        text: element['text'],
        terjemah: element['translation_id'],
        tafsir:
            surats[noSurat -
                1]['tafsir']['id']['kemenag']['text']['${element['number']}'],
      );
    }).toList();
  }

  @override
  Future<List<Surat>> getListSurat() async {
    final quranJson = await localData.loadQuranJson();
    final List<dynamic> surats = jsonDecode(quranJson);
    return surats.map<Surat>((element) {
      return Surat(
        name: element['name'],
        arabName: element['name_translations']['ar'],
        indoName: element['name_translations']['id'],
        type: element['type'],
        noSurat: element['number_of_surah'],
        jmlAyat: element['number_of_ayah'],
      );
    }).toList();
  }
}
