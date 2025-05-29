import 'package:adhan_dart/adhan_dart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quran_clean/modules/sholat/data/datasources/sholat_local_datasource.dart';

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
  final localData = SholatLocalDatasource();

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
    if (await localData.hasData('location_cache')) {
      final cached = await localData.readBox('location_cache');
      return Location(
        cityName: cached['cityName'],
        countryName: cached['countryName'],
        latitude: cached['latitude'],
        longitude: cached['longitude'],
      );
    }

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
    final location = Location(
      cityName: data["city"],
      countryName: data["countryName"],
      latitude: position.latitude,
      longitude: position.longitude,
    );

    localData.writeBox('location_cache', {
      'cityName': location.cityName,
      'countryName': location.countryName,
      'latitude': location.latitude,
      'longitude': location.longitude,
    });

    return location;
  }

  @override
  Future<WaktuSholat> getPrayerTime(Location location) async {
    PrayerTimes prayerTimesData = await adhan.getPrayerTimes(
      location.latitude,
      location.longitude,
    );

    String next = prayerTimesData.nextPrayer();
    var nextPrayerTime = prayerTimesData.timeForPrayer(next);

    String nextId = switch (next) {
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
      nextPrayer: nextId,
      nextPrayerTime: nextPrayerTime!.add(Duration(hours: addTimeZone)),
    );
  }

  @override
  Future<double> getQiblaDirectrion(Location location) async {
    return await adhan.getQiblaDirection(location.latitude, location.longitude);
  }
}
