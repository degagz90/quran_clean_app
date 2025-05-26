import '../../../audio/domain/use_cases/pause_play_audio.dart';

class PausePlayMurottal {
  PausePlayAudio _pausePlayAudioUseCase;
  PausePlayMurottal(this._pausePlayAudioUseCase);

  Future<void> execute() async {
    await _pausePlayAudioUseCase.execute();
  }
}
