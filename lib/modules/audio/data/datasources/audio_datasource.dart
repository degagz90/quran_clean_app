import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioDatasource {
  final _player = AudioPlayer();
  final _adhanPlayer = AudioPlayer();

  Future<void> playRemoteAudio(String url) async {
    await _player.stop();
    _player.setUrl(url);
    await _player.play();
  }

  Future<void> pausePlayAudio() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.seek(Duration.zero);
      await _player.play();
    }
  }

  Future<void> stopAudio() async {
    await _player.stop();
  }

  Stream<ProcessingState> get processingStateStream =>
      _player.processingStateStream;

  Future<void> playAdzan(String sholat) async {
    //set audioSource sesuai sholat
    AudioSource audioSource;
    if (sholat == "Subuh") {
      audioSource = AudioSource.asset(
        "assets/audios/fajr_adzan.mp3",
        tag: MediaItem(id: "1", title: "Adzan Subuh"),
      );
    } else {
      audioSource = AudioSource.asset(
        "assets/audios/adzan.mp3",
        tag: MediaItem(id: "2", title: "Adzan $sholat"),
      );
    }
    //stop player lain jika sedang memutar
    if (_player.playing) {
      await stopAudio();
    }
    //putar adzan
    _adhanPlayer.setAudioSource(audioSource);

    await _adhanPlayer.play();
    if (_adhanPlayer.processingState == ProcessingState.completed) {
      await _adhanPlayer.stop();
    }
  }
}
