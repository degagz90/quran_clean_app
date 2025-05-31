import '../../../../core/utils/formater.dart';
import '../../../audio/domain/usecases/play_audio_url.dart';
import '../../../settings/domain/models/setting.dart';

class PlayMurottalAudio {
  final PlayAudioUrl _playAudioUrlUseCase;

  PlayMurottalAudio(this._playAudioUrlUseCase);

  Future<void> execute(Qari qari, int noSurat, int noAyat) async {
    final qariUrl = switch (qari.name) {
      "haniRifai" => "Hani_Rifai_192kbps",
      "ashShatree" => "Abu_Bakr_Ash-Shaatree_128kbps",
      "alAfasy" => "Alafasy_128kbps",
      _ => "Hani_Rifai_192kbps",
    };
    final noSuratUrl = Formater.numberFormatToURL(noSurat);
    final noAyatUrl = Formater.numberFormatToURL(noAyat);
    final audioUrl =
        "https://everyayah.com/data/$qariUrl/$noSuratUrl$noAyatUrl.mp3";
    await _playAudioUrlUseCase.execute(audioUrl);
  }
}
