import 'dart:async';

import 'package:get/get.dart';

import '../../../notification/data/repositories/local_notification_repository_impl.dart';
import '../../../notification/domain/usecases/show_notification.dart';
import '../../../settings/data/repositories/setting_repository_impl.dart';
import '../../../settings/domain/usecases/get_setting.dart';
import '../../data/repositories/sholat_repository_impl.dart';
import '../../domain/models/hijri_date.dart';
import '../../domain/models/location.dart';
import '../../domain/models/waktu_sholat.dart';
import '../../domain/usecases/get_hijri_date.dart';
import '../../domain/usecases/get_location.dart';
import '../../domain/usecases/get_qibla.dart';
import '../../domain/usecases/get_sholat_setting.dart';
import '../../domain/usecases/get_waktu_sholat.dart';
import '../../domain/usecases/sholat_notification.dart';

class SholatController extends GetxController {
  final repository = SholatRepositoryImpl();
  final settingRepository = SettingRepositoryImpl();
  final notificationRepository = LocalNotificationRepositoryImpl();
  Rx<DateTime> now = DateTime.now().obs;
  Rx<Location?> location = Rx<Location?>(null);
  Rx<HijriDate?> hijriDate = Rx<HijriDate?>(null);
  Rx<WaktuSholat?> waktuSholat = Rx<WaktuSholat?>(null);
  Rx<Duration> countDown = Duration.zero.obs;
  double arahKiblat = 0;
  int timeZone = 0;
  Timer? _timer2;
  Timer? _timer;
  bool isAdzanPlay = false;

  @override
  void onInit() {
    getSetting();
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
        if (isAdzanPlay && waktuSholat.value!.nextPrayer != "Terbit") {
          print(waktuSholat.value!.nextPrayer);
          await adzanNotif(waktuSholat.value!.nextPrayer);
        }
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
    hijriDate.value = await hijriDateUseCase.execute(DateTime.now());
  }

  Future<void> getLocation() async {
    if (location.value != null) return;
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

  Future<void> getQibla(Location location) async {
    final getQiblaUseCase = GetQibla(repository);
    var direction = await getQiblaUseCase.execute(location);
    if (direction > 180.000000000000) {
      direction = direction - 360;
    }
    arahKiblat = direction;
  }

  Future<void> getSetting() async {
    final getSettingUseCase = GetSetting(settingRepository);
    final useCase = GetSholatSetting(getSettingUseCase);
    final setting = await useCase.execute();
    isAdzanPlay = setting.playAdzan;
  }

  Future<void> adzanNotif(String sholat) async {
    final showNotifUseCase = ShowNotification(notificationRepository);
    final useCase = SholatNotification(showNotifUseCase);
    await useCase.execute(sholat);
  }
}
