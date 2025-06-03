import 'package:adhan_dart/adhan_dart.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/utils/formater.dart';
import '../../domain/models/hijri_date.dart';
import '../../domain/models/location.dart';
import '../../domain/models/next_sholat.dart';
import '../../domain/models/waktu_sholat.dart';
import '../../domain/repositories/sholat_repository.dart';
import '../datasources/sholat_adhan_datasource.dart';
import '../datasources/sholat_geolocator_datasource.dart';
import '../datasources/sholat_local_datasource.dart';
import '../datasources/sholat_remote_datasource.dart';

class SholatRepositoryImpl implements SholatRepository {
  final remoteData = SholatRemoteDatasource();
  final geolocator = SholatGeolocatorDatasource();
  final adhan = SholatAdhanDatasource();
  final localData = SholatLocalDatasource();

  @override
  Future<HijriDate> getHijriyahDate(DateTime dateTime) async {
    //cek data dari cache
    var cachedData = await localData.readCache("hijri_date");
    //kalau ada data langsung kembalikan HijriDate
    if (cachedData != null) {
      return HijriDate(
        tanggal: cachedData["tanggal"],
        bulan: cachedData["bulan"],
        tahun: cachedData["tahun"],
      );
    }
    //kalau tidak ada data fetch data dari API
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
    //setelah itu tulis ke cache, dihapus ketika berganti tanggal
    final tomorrow = DateTime.now().add(Duration(days: 1));
    final expTime = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
    await localData.writeCache("hijri_date", {
      "tanggal": hijriDate.tanggal,
      "bulan": hijriDate.bulan,
      "tahun": hijriDate.tahun,
    }, expTime);
    //kembalikan hijriDate
    return hijriDate;
  }

  @override
  Future<Location> getLocation() async {
    //cek data dari cache
    var cachedData = await localData.readCache("location_cache");
    //kalau ada data langsung kembalikan Location
    if (cachedData != null) {
      return Location(
        wilayah: cachedData['wilayah'],
        kota: cachedData['kota'],
        timeZone: cachedData['timeZone'],
        latitude: cachedData['latitude'],
        longitude: cachedData['longitude'],
      );
    }
    //kalau tidak ada data, fetch data dari geolocator + reverse geocode
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
    final List<Map<String, dynamic>> informasi = List.from(
      data["localityInfo"]["informative"],
    );
    final String timeZone = informasi.firstWhere(
      (element) => element["description"] == "zona waktu",
    )["name"];
    final location = Location(
      wilayah: data["locality"],
      kota: data["city"],
      timeZone: timeZone,
      latitude: position.latitude,
      longitude: position.longitude,
    );
    // setelah itu tulis ke cache, akan dihapus setiap 15 menit
    final expTime = DateTime.now().add(Duration(minutes: 15));

    await localData.writeCache('location_cache', {
      'wilayah': location.wilayah,
      'kota': location.kota,
      'timeZone': location.timeZone,
      'latitude': location.latitude,
      'longitude': location.longitude,
    }, expTime);
    // kembalikan location
    return location;
  }

  @override
  Future<WaktuSholat> getPrayerTime(Location location) async {
    //cek cache apakah sudah ada data
    final cacheKey = "waktu_sholat";
    var cachedData = await localData.readCache(cacheKey);
    //cek cache apakah lat dan long ada perubahan
    if (cachedData != null &&
        cachedData["locationLat"] == location.latitude &&
        cachedData["locationLong"] == location.longitude) {
      return WaktuSholat(
        subuhTime: DateTime.parse(cachedData['subuhTime']),
        terbitTime: DateTime.parse(cachedData['terbitTime']),
        dzuhurTime: DateTime.parse(cachedData['dzuhurTime']),
        asharTime: DateTime.parse(cachedData['asharTime']),
        maghribTime: DateTime.parse(cachedData['maghribTime']),
        isyaTime: DateTime.parse(cachedData['isyaTime']),
        locationLat: cachedData['locationLat'],
        locationLong: cachedData['locationLong'],
      );
    }

    //kalau ada perubahan maka fetch ulang data
    PrayerTimes prayerTimesData = await adhan.getPrayerTimes(
      location.latitude,
      location.longitude,
    );

    final waktuSholat = WaktuSholat(
      subuhTime: prayerTimesData.fajr!,
      terbitTime: prayerTimesData.sunrise!,
      dzuhurTime: prayerTimesData.dhuhr!,
      asharTime: prayerTimesData.asr!,
      maghribTime: prayerTimesData.maghrib!,
      isyaTime: prayerTimesData.isha!,
      locationLat: location.latitude,
      locationLong: location.longitude,
    );
    // simpan ke cache, hapus jika tanggal berubah
    final tomorrow = DateTime.now().add(Duration(days: 1));
    final expTime = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
    await localData.writeCache(cacheKey, {
      "subuhTime": waktuSholat.subuhTime.toIso8601String(),
      "terbitTime": waktuSholat.terbitTime.toIso8601String(),
      "dzuhurTime": waktuSholat.dzuhurTime.toIso8601String(),
      "asharTime": waktuSholat.asharTime.toIso8601String(),
      "maghribTime": waktuSholat.maghribTime.toIso8601String(),
      "isyaTime": waktuSholat.isyaTime.toIso8601String(),
      "locationLat": waktuSholat.locationLat,
      "locationLong": waktuSholat.locationLong,
    }, expTime);

    //kembalikan waktusholat
    return waktuSholat;
  }

  @override
  Future<double> getQiblaDirectrion(Location location) async {
    return await adhan.getQiblaDirection(location.latitude, location.longitude);
  }

  @override
  Future<NextSholat> getNextPrayer(Location location) async {
    //fetch data dari adhan
    final prayerTimes = await adhan.getPrayerTimes(
      location.latitude,
      location.longitude,
    );
    final String nextPrayer = prayerTimes.nextPrayer();
    final nextPrayerTime = prayerTimes.timeForPrayer(nextPrayer);
    //ubah nama prayer ke dalam bahasa Indonesia
    final prayerNameId = switch (nextPrayer) {
      "fajr" || "fajrafter" => "Subuh",
      "sunrise" => "Terbit",
      "dhuhr" => "Dzuhur",
      "asr" => "Ashar",
      "maghrib" => "Maghrib",
      "isha" => "Isya",
      _ => "no data",
    };
    //kembalikan nexprayer
    return NextSholat(
      nextSholatName: prayerNameId,
      nextSholatTime: nextPrayerTime!,
    );
  }
}
