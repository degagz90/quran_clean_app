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
  Future<Surat> findSurat(int noSurat) {
    // TODO: implement findSurat
    throw UnimplementedError();
  }

  @override
  Future<List<Ayat>> getListAyat(int noSurat) {
    // TODO: implement getListAyat
    throw UnimplementedError();
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
