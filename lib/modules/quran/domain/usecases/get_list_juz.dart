import '../models/juz.dart';
import '../repositories/quran_repository.dart';

class GetListJuz {
  final QuranRepository repository;
  GetListJuz(this.repository);

  Future<List<Juz>> execute() async {
    return await repository.getListJuz();
  }
}
