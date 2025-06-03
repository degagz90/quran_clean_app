import 'package:quran_clean/modules/sholat/domain/models/next_sholat.dart';

import '../models/hijri_date.dart';
import '../models/location.dart';
import '../models/waktu_sholat.dart';

abstract class SholatRepository {
  Future<HijriDate> getHijriyahDate(DateTime dateTime);
  Future<Location> getLocation();
  Future<WaktuSholat> getPrayerTime(Location location);
  Future<NextSholat> getNextPrayer(Location location);
  Future<double> getQiblaDirectrion(Location location);
}
