import '../../../../core/utils/formater.dart';
import '../../../audio/domain/use_cases/play_audio_url.dart';

class PlayMurottalAudio {
  final PlayAudioUrl _playAudioUrlUseCase;

  PlayMurottalAudio(this._playAudioUrlUseCase);

  Future<void> execute(String qari, int noSurat, int noAyat) async {
    final qariUrl = switch (qari.toLowerCase()) {
      "hani rifai" => "Hani_Rifai_192kbps",
      _ => "Hani_Rifai_192kbps",
    };
    final noSuratUrl = Formater.numberFormatToURL(noSurat);
    final noAyatUrl = Formater.numberFormatToURL(noAyat);
    final audioUrl =
        "https://everyayah.com/data/$qariUrl/$noSuratUrl$noAyatUrl.mp3";
    await _playAudioUrlUseCase.execute(audioUrl);
  }
}
