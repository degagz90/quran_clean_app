import 'package:get/get.dart';

import '../../data/repositories/quran_repository_impl.dart';
import '../../domain/models/juz.dart';
import '../../domain/models/surat.dart';
import '../../domain/use_cases/load_list_juz.dart';
import '../../domain/use_cases/load_list_surat.dart';

class QuranController extends GetxController {
  final repository = QuranRepositoryImpl();
  List<Surat> listSurat = [];
  List<Juz> listJuz = [];

  Future<void> loadSuratList() async {
    final useCase = LoadListSurat(repository);
    try {
      listSurat = await useCase.execute();
    } catch (e) {
      // print(e);
    }
  }

  Future<void> loadJuzList() async {
    final useCase = LoadListJuz(repository: repository);
    try {
      listJuz = await useCase.execute();
    } catch (e) {
      print(e);
    }
  }
}
