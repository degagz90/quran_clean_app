import 'package:quran_clean/modules/audio/domain/usecases/stop_audio.dart';

class StopMurottal {
  final StopAudio _stopAudioUseCase;
  StopMurottal(this._stopAudioUseCase);

  Future<void> execute() async {
    await _stopAudioUseCase.execute();
  }
}
