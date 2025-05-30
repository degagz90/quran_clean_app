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
    final cachekey = "hijriDate";
    //cek apakah sudah ada cachedData
    var cachedData = await localData.readCache(cachekey);
    //kalau tidak null langsung return HijriDate dari cachedData
    if (cachedData != null) {
      print('ada data');
      return HijriDate(
        tanggal: cachedData['tanggal'],
        bulan: cachedData['namabulan'],
        tahun: cachedData['tahun'],
      );
    }
    // kalau null, fetch data dari internet
    String urlDate = Formater.tanggalToUrl(dateTime);
    var data = await remoteData.fetchData(
      url:
          "https://service.unisayogya.ac.id/kalender/api/masehi2hijriah/muhammadiyah/$urlDate",
    );
    final hijriDate = HijriDate(
      tanggal: data["tanggal"].toString(),
      bulan: data["namabulan"],
      tahun: data["tahun"].toString(),
    );
    //setelah itu write ke storage,
    await localData.writeCache(cachekey, {
      'tanggal': hijriDate.tanggal,
      'namabulan': hijriDate.bulan,
      'tahun': hijriDate.tahun,
    });
    return hijriDate;
  }

  @override
  Future<Location> getLocation() async {
    var cachedData = await localData.readCache("location_cache");
    if (cachedData != null) {
      return Location(
        wilayah: cachedData['wilayah'],
        kota: cachedData['kota'],
        latitude: cachedData['latitude'],
        longitude: cachedData['longitude'],
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
      wilayah: data["locality"],
      kota: data["city"],
      latitude: position.latitude,
      longitude: position.longitude,
    );

    await localData.writeCache('location_cache', {
      'wilayah': location.wilayah,
      'kota': location.kota,
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
      "dhuhr" => "Dzuhur",
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
