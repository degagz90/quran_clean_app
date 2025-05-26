import '../repositories/quran_repository.dart';

class AudioManager {
  final QuranRepository repository;
  AudioManager(this.repository);

  Future<void> playAudioAyat(int noSurat, int noAyat) async {
    await repository.playAudioAyat(noSurat, noAyat);
  }

  Future<void> pausePlayAudio() async {
    await repository.pausePlayAudio();
  }

  Future<void> stopAudio() async {
    await repository.stopAudio();
  }
}
