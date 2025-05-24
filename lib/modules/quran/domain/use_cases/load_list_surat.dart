import '../models/surat.dart';
import '../repositories/quran_repository.dart';

class LoadListSurat {
  final QuranRepository repository;
  LoadListSurat(this.repository);

  Future<List<Surat>> execute() async {
    return await repository.getListSurat();
  }
}
