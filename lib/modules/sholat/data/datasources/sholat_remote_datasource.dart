import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:quran_clean/core/utils/formater.dart';
import 'package:quran_clean/modules/sholat/domain/models/hijri_date.dart';

import '../../domain/models/location.dart';

class SholatRemoteDatasource extends GetConnect {
  Future<Location> getLocationData() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    var response = await get(
      "https://us1.api-bdc.net/data/reverse-geocode-client",
      query: {
        "latitude": (position.latitude).toString(),
        "longitude": (position.longitude).toString(),
        "localityLanguage": "id",
      },
    );

    if (response.statusCode == 200) {
      return Location(
        cityName: response.body["city"],
        countryName: response.body["countryName"],
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } else {
      return Future.error(
        "tidak bisa menemukan lokasi: ${response.statusText}",
      );
    }
  }

  Future<HijriDate> getHijriDate(DateTime dateTime) async {
    String urlDate = Formater.tanggalToUrl(dateTime);
    Response response = await get(
      "https://service.unisayogya.ac.id/kalender/api/masehi2hijriah/muhammadiyah/$urlDate",
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.body;
      return HijriDate(
        tanggal: data["tanggal"].toString(),
        bulan: data["namabulan"],
        tahun: data["tahun"].toString(),
      );
    } else {
      return Future.error(
        "tidak bisa mengkonversi tanggal: ${response.statusText}",
      );
    }
  }
}
