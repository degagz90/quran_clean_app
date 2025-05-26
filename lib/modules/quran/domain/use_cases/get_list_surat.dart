import '../models/surat.dart';
import '../repositories/quran_repository.dart';

class GetListSurat {
  final QuranRepository repository;
  GetListSurat(this.repository);

  Future<List<Surat>> execute() async {
    return await repository.getListSurat();
  }
}
