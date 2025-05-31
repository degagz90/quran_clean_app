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
import '../../../bookmark/domain/model/bookmark.dart';
import '../../../bookmark/domain/usecases/add_bookmark.dart';
import '../../../bookmark/domain/usecases/delete_bookmark.dart';
import '../../../bookmark/domain/usecases/edit_bookmark.dart';
import '../../../bookmark/domain/usecases/find_bookmark.dart';
import '../../../bookmark/domain/usecases/is_bookmarked.dart';
import '../../../bookmark/presentation/controllers/bookmark_controller.dart';
import '../../../settings/data/repositories/setting_repository_impl.dart';
import '../../../settings/domain/models/setting.dart';
import '../../../settings/domain/usecases/get_setting.dart';
import '../../data/repositories/quran_repository_impl.dart';
import '../../domain/models/ayat.dart';
import '../../domain/models/surat.dart';
import '../../domain/usecases/ayat_to_bookmark.dart';
import '../../domain/usecases/delete_ayat_bookmark.dart';
import '../../domain/usecases/edit_ayat_bookmark.dart';
import '../../domain/usecases/find_bookmark_by_ayat.dart';
import '../../domain/usecases/get_audio_setting.dart';
import '../../domain/usecases/get_murottal_playing.dart';
import '../../domain/usecases/get_surat_detail.dart';
import '../../domain/usecases/is_ayat_bookmarked.dart';
import '../../domain/usecases/pause_play_murottal.dart';
import '../../domain/usecases/play_murottal_audio.dart';
import '../../domain/usecases/save_last_read.dart';
import '../../domain/usecases/stop_murottal.dart';
import 'quran_controller.dart';

class SuratDetailController extends GetxController {
  final quranRepository = QuranRepositoryImpl();
  final audioRepository = AudioRepositoryImpl();
  final bookmarkRepository = BookmarkRepositoryImpl();
  final settingRepository = SettingRepositoryImpl();
  late final StreamSubscription<ProcessingState> _playerSub;
  RxInt noSurat = 0.obs;
  RxInt noAyat = 0.obs;
  Surat? surat;
  List<Ayat> listAyat = [];
  PageController pageC = PageController();
  TextEditingController textAddC = TextEditingController();
  TextEditingController textEditC = TextEditingController();
  RxInt lastReadAyat = 0.obs;
  RxBool isPlaying = false.obs;
  RxInt playingAyatIndex = (-1).obs;
  RxInt searchedAyatIndex = (-1).obs;
  Qari qari = Qari.alAfasy;
  bool continuesPlay = true;

  @override
  void onInit() {
    getAudioSetting();
    noSurat.value = Get.arguments['no_surat'];
    noAyat.value = Get.arguments['no_ayat'] ?? 0;
    pageC = PageController(initialPage: noSurat.value - 1);
    final getAudioStateUseCase = GetAudioPlayerState(audioRepository);
    final getMurotalStateUseCase = GetMurottalPlaying(getAudioStateUseCase);
    _playerSub = getMurotalStateUseCase.execute().listen((state) async {
      if (state == ProcessingState.completed) {
        if (continuesPlay &&
            isPlaying.value &&
            playingAyatIndex.value + 1 < surat!.jmlAyat) {
          // Next ayat
          final nextAyat = playingAyatIndex.value + 2;
          await playMurottal(noSurat.value, nextAyat);
        } else {
          isPlaying.value = false;
          playingAyatIndex.value = -1;
        }
      }
    });

    super.onInit();
  }

  @override
  void onClose() async {
    await stopMurottal();
    await saveLastRead(noSurat.value, lastReadAyat.value);
    Get.find<QuranController>().getLastRead();
    Get.find<BookmarkController>().getBookmarks();
    _playerSub.cancel();
    super.onClose();
  }

  Future<void> getAudioSetting() async {
    final getSetting = GetSetting(settingRepository);
    final useCase = GetAudioSetting(getSetting);
    Setting setting = await useCase.execute();
    qari = setting.qari;
    continuesPlay = setting.continuesPlay;
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
    searchedAyatIndex.value = -1;
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
    await useCase.execute(qari, noSurat, noAyat);
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

  Future<bool> isBookmarked(int noSurat, int noAyat) async {
    final isBookmarkedUseCase = IsBookmarked(bookmarkRepository);
    final useCase = IsAyatBookmarked(isBookmarkedUseCase);
    return await useCase.execute(noSurat, noAyat);
  }

  Future<Bookmark> findBookmark(int noSurat, int noAyat) async {
    final findBookmarkUseCase = FindBookmark(bookmarkRepository);
    final useCase = FindBookmarkByAyat(findBookmarkUseCase);
    return await useCase.execute(noSurat, noAyat);
  }

  Future<void> editBookmark(Bookmark bookmark) async {
    final editBookmarkUseCase = EditBookmark(bookmarkRepository);
    final useCase = EditAyatBookmark(editBookmarkUseCase);
    await useCase.execute(bookmark);
  }

  Future<void> deleteBookmark(Bookmark bookmark) async {
    final deleteBookmarkUseCase = DeleteBookmark(bookmarkRepository);
    final useCase = DeleteAyatBookmark(deleteBookmarkUseCase);
    await useCase.execute(bookmark);
  }
}
