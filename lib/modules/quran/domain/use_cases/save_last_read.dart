import 'package:quran_clean/modules/quran/domain/repositories/quran_repository.dart';

class SaveLastRead {
  final QuranRepository repository;
  SaveLastRead(this.repository);

  Future<void> execute(int noSurat, int noAyat) async {
    await repository.saveLastRead(noSurat, noAyat);
  }
}
