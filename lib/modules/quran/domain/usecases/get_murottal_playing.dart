import 'package:just_audio/just_audio.dart';
import 'package:quran_clean/modules/audio/domain/usecases/get_audio_player_state.dart';

class GetMurottalPlaying {
  GetAudioPlayerState getAudioPlayerState;
  GetMurottalPlaying(this.getAudioPlayerState);

  Stream<ProcessingState> execute() => getAudioPlayerState.execute();
}
