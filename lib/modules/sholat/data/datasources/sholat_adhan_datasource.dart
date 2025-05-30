import 'package:adhan_dart/adhan_dart.dart';

class SholatAdhanDatasource {
  Future<PrayerTimes> getPrayerTimes(double latitude, double longitude) async {
    Coordinates coordinates = Coordinates(latitude, longitude);
    // Coordinates coordinates = Coordinates(-7.805054, 110.361517);
    CalculationParameters params = CalculationMethod.singapore();
    params.madhab = Madhab.shafi;
    params.adjustments = {
      'fajr': 2,
      'sunrise': -3,
      'dhuhr': 2,
      'asr': 2,
      'maghrib': 2,
      'isha': 2,
    };

    PrayerTimes prayerTimes = PrayerTimes(
      coordinates: coordinates,
      calculationParameters: params,
      date: DateTime.now(),
    );

    return prayerTimes;
  }

  Future<double> getQiblaDirection(double latitude, double longitude) async {
    Coordinates coordinates = Coordinates(latitude, longitude);
    return Qibla.qibla(coordinates);
  }
}
