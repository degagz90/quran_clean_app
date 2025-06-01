import 'package:just_audio/just_audio.dart';

import '../datasources/audio_datasource.dart';
import '../../domain/repositories/audio_repository.dart';

class AudioRepositoryImpl implements AudioRepository {
  final audioDatasource = AudioDatasource();

  @override
  Future<void> pausePlayAudio() async {
    await audioDatasource.pausePlayAudio();
  }

  @override
  Future<void> playRemoteAudio(String url) async {
    await audioDatasource.playRemoteAudio(url);
  }

  @override
  Future<void> stopAudio() async {
    await audioDatasource.stopAudio();
  }

  @override
  Stream<ProcessingState> get processingStateStream =>
      audioDatasource.processingStateStream;

  @override
  Future<void> playAdzan(String sholat) async {
    final idSholat = switch (sholat) {
      "fajr" => "Subuh",
      "dhuhr" => "Dzuhur",
      "asr" => "Ashar",
      "maghrib" => "Maghrib",
      "isha" => "Isya",
      _ => "",
    };
    await audioDatasource.playAdzan(idSholat);
  }
}
