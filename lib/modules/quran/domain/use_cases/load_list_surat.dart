import 'package:quran_clean/modules/quran/domain/models/surat.dart';
import 'package:quran_clean/modules/quran/domain/repositories/quran_repository.dart';

class LoadListSurat {
  final QuranRepository repository;
  LoadListSurat(this.repository);

  Future<List<Surat>> execute() async {
    return await repository.getListSurat();
  }
}
