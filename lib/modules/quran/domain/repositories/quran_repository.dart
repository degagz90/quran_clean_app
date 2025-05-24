import '../models/ayat.dart';
import '../models/surat.dart';

abstract class QuranRepository {
  Future<List<Surat>> getListSurat();
  Future<List<Ayat>> getListAyat(int noSurat);
  Future<Surat> findSurat(int noSurat);
  Future<Ayat> findAyat(int noSurat, int noAyat);
}
