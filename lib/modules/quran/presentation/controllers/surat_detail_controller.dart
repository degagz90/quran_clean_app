import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../data/repositories/quran_repository_impl.dart';
import '../../domain/models/ayat.dart';
import '../../domain/models/surat.dart';
import '../../domain/use_cases/audio_manager.dart';
import '../../domain/use_cases/memory_manager.dart';
import '../../domain/use_cases/quran_loader.dart';
import 'quran_controller.dart';

class SuratDetailController extends GetxController {
  final repository = QuranRepositoryImpl();
  RxInt noSurat = 0.obs;
  RxInt noAyat = 0.obs;
  Surat? surat;
  List<Ayat> listAyat = [];
  PageController pageC = PageController();
  RxInt lastReadAyat = 0.obs;
  RxBool isPlaying = false.obs;
  RxInt playingAyatIndex = (-1).obs;
  bool _isActive = true;

  @override
  void onInit() {
    _isActive = true;
    noSurat.value = Get.arguments['no_surat'];
    noAyat.value = Get.arguments['no_ayat'] ?? 0;
    pageC = PageController(initialPage: noSurat.value - 1);
    super.onInit();
  }

  @override
  void onClose() async {
    _isActive = false;
    await stopAudio();
    await saveLastRead(noSurat.value, lastReadAyat.value);
    Get.find<QuranController>().getLastRead();
    super.onClose();
  }

  Future<void> findSurat() async {
    final useCase = QuranLoader(repository);
    try {
      surat = await useCase.findSurat(noSurat.value);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> getListAyat() async {
    final useCase = QuranLoader(repository);
    try {
      listAyat = await useCase.getListAyat(noSurat.value);
    } catch (e) {
      // print(e);
    }
  }

  void resetPage() async {
    listAyat.clear();
    surat = null;
    noAyat.value = 1;
  }

  void findLastRead(Iterable<ItemPosition> positions) {
    if (positions.isNotEmpty) {
      // Ambil ayat pertama yang terlihat di layar
      final firstVisible = positions
          .map((e) => e.index)
          .reduce((a, b) => a < b ? a : b);
      lastReadAyat.value = listAyat[firstVisible].noAyat;
    }
  }

  Future<void> saveLastRead(int noSurat, int noAyat) async {
    final useCase = MemoryManager(repository);
    try {
      await useCase.saveLastRead(noSurat, noAyat);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> playAudioAyat(int noSurat, int noAyat) async {
    final useCase = AudioManager(repository);
    if (!_isActive) return;
    // Jika sedang play ayat lain, hentikan dulu
    if (isPlaying.value) {
      await useCase.stopAudio();
    }
    playingAyatIndex.value = noAyat - 1;
    isPlaying.value = true;
    await useCase.playAudioAyat(noSurat, noAyat);
    if (_isActive && noAyat < surat!.jmlAyat && isPlaying.value) {
      noAyat++;
      await playAudioAyat(noSurat, noAyat);
    } else {
      isPlaying.value = false;
      playingAyatIndex.value = -1;
    }
  }

  Future<void> stopAudio() async {
    final useCase = AudioManager(repository);
    isPlaying.value = false;
    playingAyatIndex.value = -1;
    await useCase.stopAudio();
  }

  Future<void> pausePlayAudio() async {
    final useCase = AudioManager(repository);
    isPlaying.value = !isPlaying.value;
    await useCase.pausePlayAudio();
  }
}
