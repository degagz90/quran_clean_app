import 'package:get/get.dart';

import '../../data/repositories/quran_repository_impl.dart';
import '../../domain/models/juz.dart';
import '../../domain/models/surat.dart';
import '../../domain/use_cases/get_last_read.dart';
import '../../domain/use_cases/get_list_juz.dart';
import '../../domain/use_cases/get_list_surat.dart';

class QuranController extends GetxController {
  final repository = QuranRepositoryImpl();
  List<Surat> listSurat = [];
  List<Juz> listJuz = [];
  RxInt lastSuratNo = 0.obs;
  RxInt lastAyatNo = 0.obs;

  @override
  void onInit() async {
    await getLastRead();
    super.onInit();
  }

  Future<void> loadSuratList() async {
    final useCase = GetListSurat(repository);
    try {
      listSurat = await useCase.execute();
    } catch (e) {
      // print(e);
    }
  }

  Future<void> loadJuzList() async {
    final useCase = GetListJuz(repository);
    try {
      listJuz = await useCase.execute();
    } catch (e) {
      // print(e);
    }
  }

  Future<void> getLastRead() async {
    final useCase = GetLastRead(repository);
    try {
      final listInt = await useCase.execute();
      lastSuratNo.value = listInt[0];
      lastAyatNo.value = listInt[1];
      // print("${lastSuratNo.value}, ${lastAyatNo.value}");
    } catch (e) {
      print(e);
    }
  }
}
