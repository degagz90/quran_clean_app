import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../audio/data/repositories/audio_repository_impl.dart';
import '../../../audio/domain/usecases/get_audio_player_state.dart';
import '../../../audio/domain/usecases/pause_play_audio.dart';
import '../../../audio/domain/usecases/play_audio_url.dart';
import '../../../audio/domain/usecases/stop_audio.dart';
import '../../../bookmark/data/repositories/bookmark_repository_impl.dart';
import '../../../bookmark/domain/usecases/add_bookmark.dart';
import '../../data/repositories/quran_repository_impl.dart';
import '../../domain/models/ayat.dart';
import '../../domain/models/surat.dart';
import '../../domain/usecases/ayat_to_bookmark.dart';
import '../../domain/usecases/get_murottal_playing.dart';
import '../../domain/usecases/get_surat_detail.dart';
import '../../domain/usecases/pause_play_murottal.dart';
import '../../domain/usecases/play_murottal_audio.dart';
import '../../domain/usecases/save_last_read.dart';
import '../../domain/usecases/stop_murottal.dart';
import 'quran_controller.dart';

class SuratDetailController extends GetxController {
  final quranRepository = QuranRepositoryImpl();
  final audioRepository = AudioRepositoryImpl();
  final bookmarkRepository = BookmarkRepositoryImpl();
  late final StreamSubscription<ProcessingState> _playerSub;
  RxInt noSurat = 0.obs;
  RxInt noAyat = 0.obs;
  Surat? surat;
  List<Ayat> listAyat = [];
  PageController pageC = PageController();
  RxInt lastReadAyat = 0.obs;
  RxBool isPlaying = false.obs;
  RxInt playingAyatIndex = (-1).obs;

  @override
  void onInit() {
    noSurat.value = Get.arguments['no_surat'];
    noAyat.value = Get.arguments['no_ayat'] ?? 0;
    pageC = PageController(initialPage: noSurat.value - 1);
    super.onInit();
    final getAudioStateUseCase = GetAudioPlayerState(audioRepository);
    final getMurotalStateUseCase = GetMurottalPlaying(getAudioStateUseCase);
    _playerSub = getMurotalStateUseCase.execute().listen((state) async {
      if (state == ProcessingState.completed) {
        if (isPlaying.value && playingAyatIndex.value + 1 < surat!.jmlAyat) {
          // Next ayat
          final nextAyat = playingAyatIndex.value + 2;
          await playMurottal(noSurat.value, nextAyat);
        } else {
          isPlaying.value = false;
          playingAyatIndex.value = -1;
        }
      }
    });
  }

  @override
  void onClose() async {
    await stopMurottal();
    await saveLastRead(noSurat.value, lastReadAyat.value);
    Get.find<QuranController>().getLastRead();
    _playerSub.cancel();
    super.onClose();
  }

  Future<void> findSurat() async {
    final useCase = GetSuratDetail(quranRepository);
    try {
      surat = await useCase.findSurat(noSurat.value);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> getListAyat() async {
    final useCase = GetSuratDetail(quranRepository);
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
    final useCase = SaveLastRead(quranRepository);
    try {
      await useCase.execute(noSurat, lastReadAyat.value);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> playMurottal(int noSurat, int noAyat) async {
    final playaudioUrlUseCase = PlayAudioUrl(audioRepository);
    final useCase = PlayMurottalAudio(playaudioUrlUseCase);
    playingAyatIndex.value = noAyat - 1;
    isPlaying.value = true;
    await useCase.execute("ash shatree", noSurat, noAyat);
  }

  Future<void> stopMurottal() async {
    final playaudioUrlUseCase = StopAudio(audioRepository);
    final useCase = StopMurottal(playaudioUrlUseCase);
    isPlaying.value = false;
    playingAyatIndex.value = -1;
    await useCase.execute();
  }

  Future<void> pausePlayMurottal() async {
    final playaudioUrlUseCase = PausePlayAudio(audioRepository);
    final useCase = PausePlayMurottal(playaudioUrlUseCase);
    isPlaying.value = !isPlaying.value;
    await useCase.execute();
  }

  Future<void> addBookmark(
    String suratName,
    int noSurat,
    int noAyat,
    String catatan,
    String timeStamp,
  ) async {
    final addBookmarkUseCase = AddBookmark(bookmarkRepository);
    final useCase = AyatToBookmark(addBookmarkUseCase);
    await useCase.execute(suratName, noSurat, noAyat, catatan, timeStamp);
  }
}
