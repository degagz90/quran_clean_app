import '../repositories/quran_repository.dart';

class GetLastRead {
  final QuranRepository repository;
  GetLastRead(this.repository);

  Future<List<int>> execute() async {
    return await repository.getLastRead();
  }
}
