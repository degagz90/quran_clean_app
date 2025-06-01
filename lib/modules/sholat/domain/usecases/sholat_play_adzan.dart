import 'package:quran_clean/modules/audio/domain/usecases/play_adzan.dart';

class SholatPlayAdzan {
  final PlayAdzan playAdzan;
  SholatPlayAdzan(this.playAdzan);

  Future<void> execute(String sholat) async {
    await playAdzan.execute(sholat);
  }
}
