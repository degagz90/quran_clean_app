import '../repositories/audio_repository.dart';

class StopAudio {
  final AudioRepository repository;
  StopAudio(this.repository);

  Future<void> execute() async {
    await repository.stopAudio();
  }
}
