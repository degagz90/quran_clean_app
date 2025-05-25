import '../models/juz.dart';
import '../repositories/quran_repository.dart';

class LoadListJuz {
  final QuranRepository repository;
  LoadListJuz(this.repository);

  Future<List<Juz>> execute() async {
    return await repository.getListJuz();
  }
}
