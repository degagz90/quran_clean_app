import 'package:adhan_dart/adhan_dart.dart';

class SholatAdhanDatasource {
  Future<PrayerTimes> getPrayerTimes(double latitude, double longitude) async {
    Coordinates coordinates = Coordinates(latitude, longitude);
    CalculationParameters params = CalculationMethod.singapore();
    params.madhab = Madhab.shafi;

    PrayerTimes prayerTimes = PrayerTimes(
      coordinates: coordinates,
      calculationParameters: params,
      date: DateTime.now(),
    );

    return prayerTimes;
  }
}
