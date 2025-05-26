import '../repositories/audio_repository.dart';

class PlayAudioUrl {
  final AudioRepository repository;
  PlayAudioUrl(this.repository);

  Future<void> execute(String url) async {
    await repository.playRemoteAudio(url);
  }
}
