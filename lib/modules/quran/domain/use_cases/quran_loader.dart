import '../models/ayat.dart';
import '../models/juz.dart';
import '../models/surat.dart';
import '../repositories/quran_repository.dart';

class QuranLoader {
  final QuranRepository repository;
  QuranLoader(this.repository);

  Future<Surat> findSurat(int noSurat) async {
    return await repository.findSurat(noSurat);
  }

  Future<List<Ayat>> getListAyat(int noSurat) async {
    return await repository.getListAyat(noSurat);
  }

  Future<List<Surat>> getListSurat() async {
    return await repository.getListSurat();
  }

  Future<List<Juz>> getListJuz() async {
    return await repository.getListJuz();
  }
}
