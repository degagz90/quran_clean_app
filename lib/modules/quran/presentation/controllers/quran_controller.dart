import 'package:get/get.dart';

import '../../data/repositories/quran_repository_impl.dart';
import '../../domain/models/juz.dart';
import '../../domain/models/surat.dart';
import '../../domain/use_cases/memory_manager.dart';
import '../../domain/use_cases/quran_loader.dart';

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
    final useCase = QuranLoader(repository);
    try {
      listSurat = await useCase.getListSurat();
    } catch (e) {
      // print(e);
    }
  }

  Future<void> loadJuzList() async {
    final useCase = QuranLoader(repository);
    try {
      listJuz = await useCase.getListJuz();
    } catch (e) {
      // print(e);
    }
  }

  Future<void> getLastRead() async {
    final useCase = MemoryManager(repository);
    try {
      final listInt = await useCase.getLastRead();
      lastSuratNo.value = listInt[0];
      lastAyatNo.value = listInt[1];
      // print("${lastSuratNo.value}, ${lastAyatNo.value}");
    } catch (e) {
      print(e);
    }
  }
}
