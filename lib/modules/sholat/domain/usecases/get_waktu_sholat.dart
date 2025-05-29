import '../models/location.dart';
import '../models/waktu_sholat.dart';
import '../repositories/sholat_repository.dart';

class GetWaktuSholat {
  final SholatRepository repository;
  GetWaktuSholat(this.repository);

  Future<WaktuSholat> execute(Location location) async {
    return await repository.getPrayerTime(location);
  }
}
