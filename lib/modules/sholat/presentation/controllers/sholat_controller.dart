import 'dart:async';

import 'package:get/get.dart';

import '../../data/repositories/sholat_repository_impl.dart';
import '../../domain/models/hijri_date.dart';
import '../../domain/models/location.dart';
import '../../domain/models/waktu_sholat.dart';
import '../../domain/usecases/get_hijri_date.dart';
import '../../domain/usecases/get_location.dart';
import '../../domain/usecases/get_waktu_sholat.dart';

class SholatController extends GetxController {
  final repository = SholatRepositoryImpl();
  Rx<DateTime> now = DateTime.now().obs;
  Rx<Location?> location = Rx<Location?>(null);
  Rx<HijriDate?> hijriDate = Rx<HijriDate?>(null);
  Rx<WaktuSholat?> waktuSholat = Rx<WaktuSholat?>(null);
  Rx<Duration> countDown = Duration.zero.obs;
  int timeZone = 0;
  Timer? _timer2;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      now.value = DateTime.now();
    });

    _timer2 = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (location.value == null || waktuSholat.value == null) {
        return;
      }

      timeZone = getTimeZone(location.value!.longitude);

      final diff = waktuSholat.value!.nextPrayerTime.difference(
        DateTime.now().add(Duration(hours: timeZone)),
      );
      countDown.value = diff.isNegative ? Duration.zero : diff;
      if (diff.inSeconds <= 0) {
        await getWaktuSholat();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer2?.cancel();
    super.onClose();
  }

  Future<void> getHijriDate() async {
    final hijriDateUseCase = GetHijriDate(repository);
    hijriDate.value = await hijriDateUseCase.execute(now.value);
  }

  Future<void> getLocation() async {
    final locationUseCase = GetLocation(repository);
    location.value = await locationUseCase.execute();
  }

  Future<void> getWaktuSholat() async {
    final waktuSholatUseCase = GetWaktuSholat(repository);
    if (location.value != null) {
      waktuSholat.value = await waktuSholatUseCase.execute(location.value!);
    }
  }

  int getTimeZone(double longitude) {
    return switch (longitude) {
      >= 95 && < 110 => 7,
      >= 110 && < 135 => 8,
      >= 135 && <= 141 => 9,
      _ => 0,
    };
  }
}
