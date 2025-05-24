import 'package:get/get.dart';
import 'package:quran_clean/modules/quran/data/repositories/quran_repository_impl.dart';
import 'package:quran_clean/modules/quran/domain/models/surat.dart';
import 'package:quran_clean/modules/quran/domain/use_cases/load_list_surat.dart';

class QuranController extends GetxController {
  List<Surat> listSurat = [];

  Future<void> loadSuratList() async {
    final repository = QuranRepositoryImpl();
    final useCase = LoadListSurat(repository);
    try {
      listSurat = await useCase.execute();
    } catch (e) {
      print(e);
    }
  }
}
