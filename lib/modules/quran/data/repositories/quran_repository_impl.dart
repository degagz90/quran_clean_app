import 'dart:convert';
import 'package:quran_clean/core/utils/formater.dart';
import 'package:xml/xml.dart';

import '../../domain/models/ayat.dart';
import '../../domain/models/juz.dart';
import '../../domain/models/surat.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/audio_remote_datasource.dart';
import '../datasources/quran_local_datasource.dart';

class QuranRepositoryImpl implements QuranRepository {
  final localData = QuranLocalDatasource();
  final remoteAudio = AudioRemoteDatasource();

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

  @override
  Future<List<Juz>> getListJuz() async {
    final xmlDocument = await localData.loadQuranMeta();
    final elements = xmlDocument.findAllElements('juz');
    return elements.map<Juz>((child) {
      return Juz(
        noJuz: int.parse(child.getAttribute('index') ?? '0'),
        startSuratNo: int.parse(child.getAttribute('sura') ?? '0'),
        startAyatNo: int.parse(child.getAttribute('aya') ?? '0'),
      );
    }).toList();
  }

  @override
  Future<void> saveLastRead(int noSurat, int noAyat) async {
    final Map<String, int> savedAyat = {"no_surat": noSurat, "no_ayat": noAyat};
    final jsonString = jsonEncode(savedAyat);
    await localData.writeToStorage("saved_ayat", jsonString);
  }

  @override
  Future<List<int>> getLastRead() async {
    final jsonString = await localData.readFromStorage("saved_ayat");
    final Map<String, dynamic> savedAyat = jsonDecode(jsonString);
    final noSurat = savedAyat['no_surat'] as int? ?? 0;
    final noAyat = savedAyat['no_ayat'] as int? ?? 0;
    return [noSurat, noAyat];
  }

  @override
  Future<void> playAudioAyat(int noSurat, int noAyat) async {
    final noSuratStr = Formater.numberFormatToURL(noSurat);
    final noAyatStr = Formater.numberFormatToURL(noAyat);
    final audioURL =
        'https://everyayah.com/data/Hani_Rifai_192kbps/$noSuratStr$noAyatStr.mp3'; // choice
    await remoteAudio.playAudio(audioURL);
  }

  @override
  Future<void> pausePlayAudio() async {
    await remoteAudio.pausePlayAudio();
  }

  @override
  Future<void> stopAudio() async {
    await remoteAudio.stopAudio();
  }
}
