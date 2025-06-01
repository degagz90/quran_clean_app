import 'package:just_audio/just_audio.dart';

abstract class AudioRepository {
  Future<void> playRemoteAudio(String url);
  Future<void> pausePlayAudio();
  Future<void> stopAudio();
  Stream<ProcessingState> get processingStateStream;
  Future<void> playAdzan(String sholat);
}
