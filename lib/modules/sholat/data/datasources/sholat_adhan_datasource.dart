import 'package:adhan_dart/adhan_dart.dart';

class SholatAdhanDatasource {
  Future<PrayerTimes> getPrayerTimes(double latitude, double longitude) async {
    Coordinates coordinates = Coordinates(latitude, longitude);
    // Coordinates coordinates = Coordinates(-7.805054, 110.361517);
    CalculationParameters params = CalculationMethod.singapore();
    params.madhab = Madhab.shafi;
    params.adjustments = {
      'fajr': 3,
      'sunrise': -3,
      'dhuhr': 3,
      'asr': 3,
      'maghrib': 3,
      'isha': 3,
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
