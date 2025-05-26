import 'package:just_audio/just_audio.dart';

class AudioRemoteDatasource {
  final _player = AudioPlayer();

  Future<void> playAudio(String url) async {
    await _player.stop();
    await _player.setUrl(url);
    await _player.play();
  }

  Future<void> pausePlayAudio() async {
    _player.playerState.playing ? await _player.pause() : await _player.play();
  }

  Future<void> stopAudio() async {
    await _player.stop();
  }
}
