import '../models/hijri_date.dart';
import '../models/location.dart';
import '../models/prayer_time.dart';

abstract class SholatRepository {
  Future<HijriDate> getHijriyahDate(DateTime dateTime);
  Future<Location> getLocation();
  Future<PrayerTime> getPrayerTime(Location location);
  Future<double> getQiblaDirectrion(Location location);
}
