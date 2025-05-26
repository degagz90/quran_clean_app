import '../repositories/quran_repository.dart';

class MemoryManager {
  final QuranRepository repository;
  MemoryManager(this.repository);

  Future<List<int>> getLastRead() async {
    return await repository.getLastRead();
  }

  Future<void> saveLastRead(int noSurat, int noAyat) async {
    await repository.saveLastRead(noSurat, noAyat);
  }
}
