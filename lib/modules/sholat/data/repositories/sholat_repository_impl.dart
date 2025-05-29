import '../datasources/sholat_remote_datasource.dart';
import '../../domain/models/hijri_date.dart';
import '../../domain/models/location.dart';
import '../../domain/models/prayer_time.dart';
import '../../domain/repositories/sholat_repository.dart';

class SholatRepositoryImpl implements SholatRepository {
  final remoteData = SholatRemoteDatasource();

  @override
  Future<HijriDate> getHijriyahDate(DateTime dateTime) async {
    return await remoteData.getHijriDate(dateTime);
  }

  @override
  Future<Location> getLocation() async {
    return await remoteData.getLocationData();
  }

  @override
  Future<PrayerTime> getPrayerTime(Location location) {
    // TODO: implement getPrayerTime
    throw UnimplementedError();
  }

  @override
  Future<double> getQiblaDirectrion(Location location) {
    // TODO: implement getQiblaDirectrion
    throw UnimplementedError();
  }
}
