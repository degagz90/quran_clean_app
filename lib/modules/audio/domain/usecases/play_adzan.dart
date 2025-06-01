import '../repositories/audio_repository.dart';

class PlayAdzan {
  final AudioRepository repository;
  PlayAdzan(this.repository);

  Future<void> execute(String sholat) async {
    await repository.playAdzan(sholat);
  }
}
