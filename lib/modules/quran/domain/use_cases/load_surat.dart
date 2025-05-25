import '../models/ayat.dart';
import '../models/surat.dart';
import '../repositories/quran_repository.dart';

class LoadSurat {
  final QuranRepository repository;
  LoadSurat(this.repository);

  Future<Surat> findSurat(int noSurat) async {
    return await repository.findSurat(noSurat);
  }

  Future<List<Ayat>> getListAyat(int noSurat) async {
    return await repository.getListAyat(noSurat);
  }
}
