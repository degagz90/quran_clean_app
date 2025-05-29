import 'package:adhan_dart/adhan_dart.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/utils/formater.dart';
import '../../domain/models/hijri_date.dart';
import '../../domain/models/location.dart';
import '../../domain/models/waktu_sholat.dart';
import '../../domain/repositories/sholat_repository.dart';
import '../datasources/sholat_adhan_datasource.dart';
import '../datasources/sholat_geolocator_datasource.dart';
import '../datasources/sholat_remote_datasource.dart';

class SholatRepositoryImpl implements SholatRepository {
  final remoteData = SholatRemoteDatasource();
  final geolocator = SholatGeolocatorDatasource();
  final adhan = SholatAdhanDatasource();

  @override
  Future<HijriDate> getHijriyahDate(DateTime dateTime) async {
    String urlDate = Formater.tanggalToUrl(dateTime);
    var data = await remoteData.fetchData(
      url:
          "https://service.unisayogya.ac.id/kalender/api/masehi2hijriah/muhammadiyah/$urlDate",
    );
    return HijriDate(
      tanggal: data["tanggal"].toString(),
      bulan: data["namabulan"],
      tahun: data["tahun"].toString(),
    );
  }

  @override
  Future<Location> getLocation() async {
    Position position = await geolocator.getCurrentLocation();

    Map<String, String> query = {
      "latitude": (position.latitude).toString(),
      "longitude": (position.longitude).toString(),
      "localityLanguage": "id",
    };

    var data = await remoteData.fetchData(
      url: "https://us1.api-bdc.net/data/reverse-geocode-client",
      query: query,
    );
    print(data);
    return Location(
      cityName: data["city"],
      countryName: data["countryName"],
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  @override
  Future<WaktuSholat> getPrayerTime(Location location) async {
    PrayerTimes prayerTimesData = await adhan.getPrayerTimes(
      location.latitude,
      location.longitude,
    );

    String next = prayerTimesData.nextPrayer();
    var nextPrayerTime = prayerTimesData.timeForPrayer(next);

    String nextID = switch (next) {
      'fajr' || "fajrafter" => "Subuh",
      'sunrise' => "Terbit",
      "duhr" => "Dzuhur",
      "asr" => "Ashar",
      "maghrib" => "Maghrib",
      "isha" => "Isya",
      _ => "-",
    };

    int addTimeZone = switch (location.longitude) {
      >= 95 && < 110 => 7,
      >= 110 && < 135 => 8,
      >= 135 && <= 141 => 9,
      _ => 0,
    };

    return WaktuSholat(
      subuhTime: prayerTimesData.fajr!.add(Duration(hours: addTimeZone)),
      terbitTime: prayerTimesData.sunrise!.add(Duration(hours: addTimeZone)),
      dzuhurTime: prayerTimesData.dhuhr!.add(Duration(hours: addTimeZone)),
      asharTime: prayerTimesData.asr!.add(Duration(hours: addTimeZone)),
      maghribTime: prayerTimesData.maghrib!.add(Duration(hours: addTimeZone)),
      isyaTime: prayerTimesData.isha!.add(Duration(hours: addTimeZone)),
      nextPrayer: nextID,
      nextPrayerTime: nextPrayerTime!.add(Duration(hours: addTimeZone)),
    );
  }

  @override
  Future<double> getQiblaDirectrion(Location location) {
    // TODO: implement getQiblaDirectrion
    throw UnimplementedError();
  }
}
