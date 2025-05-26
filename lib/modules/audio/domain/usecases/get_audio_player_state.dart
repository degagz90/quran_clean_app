import 'package:just_audio/just_audio.dart';

import '../repositories/audio_repository.dart';

class GetAudioPlayerState {
  final AudioRepository repository;
  GetAudioPlayerState(this.repository);

  Stream<ProcessingState> execute() => repository.processingStateStream;
}
