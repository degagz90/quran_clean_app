import '../models/ayat.dart';
import '../models/juz.dart';
import '../models/surat.dart';

abstract class QuranRepository {
  Future<List<Surat>> getListSurat();
  Future<List<Juz>> getListJuz();
  Future<List<Ayat>> getListAyat(int noSurat);
  Future<Surat> findSurat(int noSurat);
  Future<Ayat> findAyat(int noSurat, int noAyat);
  Future<void> saveLastRead(int noSurat, int noAyat);
  Future<List<int>> getLastRead();
}
