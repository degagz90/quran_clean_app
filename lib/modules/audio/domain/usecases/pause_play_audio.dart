import '../repositories/audio_repository.dart';

class PausePlayAudio {
  final AudioRepository repository;
  PausePlayAudio(this.repository);

  Future<void> execute() async {
    await repository.pausePlayAudio();
  }
}
