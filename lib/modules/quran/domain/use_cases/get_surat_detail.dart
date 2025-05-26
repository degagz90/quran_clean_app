import '../models/ayat.dart';
import '../models/surat.dart';
import '../repositories/quran_repository.dart';

class GetSuratDetail {
  final QuranRepository repository;
  GetSuratDetail(this.repository);

  Future<Surat> findSurat(int noSurat) async {
    return await repository.findSurat(noSurat);
  }

  Future<List<Ayat>> getListAyat(int noSurat) async {
    return await repository.getListAyat(noSurat);
  }
}
