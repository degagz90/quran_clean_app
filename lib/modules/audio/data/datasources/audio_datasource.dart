import 'package:just_audio/just_audio.dart';

class AudioDatasource {
  final _player = AudioPlayer();

  Future<void> playRemoteAudio(String url) async {
    await _player.stop();
    _player.setUrl(url);
    await _player.play();
  }

  Future<void> pausePlayAudio() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> stopAudio() async {
    await _player.stop();
  }

  Stream<ProcessingState> get processingStateStream =>
      _player.processingStateStream;
}
