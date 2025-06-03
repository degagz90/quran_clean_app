import 'dart:async';

import 'package:get/get.dart';
import 'package:quran_clean/modules/notification/domain/usecases/cancel_all_notifications.dart';
import 'package:quran_clean/modules/notification/domain/usecases/show_notification.dart';
import 'package:quran_clean/modules/settings/domain/models/setting.dart';
import 'package:quran_clean/modules/settings/domain/usecases/get_setting.dart';
import 'package:quran_clean/modules/sholat/domain/usecases/delete_adzan_notif.dart';
import 'package:quran_clean/modules/sholat/domain/usecases/get_sholat_setting.dart';
import 'package:quran_clean/modules/sholat/domain/usecases/set_adzan_notif.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../core/utils/formater.dart';
import '../../../notification/data/repositories/local_notification_repository_impl.dart';
import '../../../settings/data/repositories/setting_repository_impl.dart';
import '../../data/repositories/sholat_repository_impl.dart';
import '../../domain/models/hijri_date.dart';
import '../../domain/models/location.dart';
import '../../domain/models/next_sholat.dart';
import '../../domain/models/waktu_sholat.dart';
import '../../domain/usecases/get_hijri_date.dart';
import '../../domain/usecases/get_location.dart';
import '../../domain/usecases/get_next_prayer.dart';
import '../../domain/usecases/get_qibla.dart';
import '../../domain/usecases/get_waktu_sholat.dart';

class SholatController extends GetxController {
  final repository = SholatRepositoryImpl();
  final settingRepository = SettingRepositoryImpl();
  final notificationRepository = LocalNotificationRepositoryImpl();
  Rx<DateTime> now = DateTime.now().obs;
  Rx<Location?> location = Rx<Location?>(null);
  Rx<HijriDate?> hijriDate = Rx<HijriDate?>(null);
  Rx<WaktuSholat?> waktuSholat = Rx<WaktuSholat?>(null);
  Rx<NextSholat?> nextSholat = Rx<NextSholat?>(null);
  Rx<Duration> countDown = Duration.zero.obs;
  double arahKiblat = 0;
  int timeZone = 0;
  Timer? _timer2;
  Timer? _timer;
  bool isAdzanPlay = false;
  bool notifOn = false;

  @override
  void onInit() {
    getAdzanSetting();
    super.onInit();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      now.value = DateTime.now();
    });

    _timer2 = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (location.value == null || nextSholat.value == null) {
        return;
      }
      final diff = nextSholat.value!.nextSholatTime.difference(DateTime.now());
      countDown.value = diff.isNegative ? Duration.zero : diff;
      if (diff.inSeconds <= 0) {
        await getNextSholat();
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
    final locationUseCase = GetLocation(repository);
    location.value = await locationUseCase.execute();
  }

  Future<void> getWaktuSholat() async {
    final waktuSholatUseCase = GetWaktuSholat(repository);
    if (location.value != null) {
      waktuSholat.value = await waktuSholatUseCase.execute(location.value!);
      if (notifOn) {
        await setAdzanNotif();
      }
    }
  }

  Future<void> getNextSholat() async {
    final nextSholatUseCase = GetNextPrayer(repository);
    if (location.value != null) {
      nextSholat.value = await nextSholatUseCase.execute(location.value!);
    }
  }

  String timeZoneFormatter(DateTime prayerTime) {
    final timezoneName = location.value!.timeZone;
    final timezone = tz.getLocation(timezoneName);
    final DateTime timeZoned = tz.TZDateTime.from(prayerTime, timezone);
    return Formater.jam(timeZoned);
  }

  Future<void> setAdzanNotif() async {
    final showNotifUseCase = ShowNotification(notificationRepository);
    final setAdzanUseCase = SetAdzanNotif(showNotifUseCase);
    //delete notif supaya tidak duplicate
    await deleteAdzanNotif();
    //set adzan subuh
    await setAdzanUseCase.execute(
      "Subuh",
      waktuSholat.value!.subuhTime,
      0,
      location.value!.timeZone,
    );
    //set adzan dzuhur
    await setAdzanUseCase.execute(
      "Dzuhur",
      waktuSholat.value!.dzuhurTime,
      1,
      location.value!.timeZone,
    );
    //set adzan ashar
    await setAdzanUseCase.execute(
      "Ashar",
      waktuSholat.value!.asharTime,
      2,
      location.value!.timeZone,
    );
    //set adzan maghrib
    await setAdzanUseCase.execute(
      "Maghrib",
      waktuSholat.value!.maghribTime,
      3,
      location.value!.timeZone,
    );
    //set adzan isya
    await setAdzanUseCase.execute(
      "Isya",
      waktuSholat.value!.isyaTime,
      4,
      location.value!.timeZone,
    );
  }

  Future<void> deleteAdzanNotif() async {
    final cancelNotifUseCase = CancelAllNotifications(notificationRepository);
    final deleteAdzanNotif = DeleteAdzanNotif(cancelNotifUseCase);
    await deleteAdzanNotif.execute();
  }

  Future<void> getAdzanSetting() async {
    final getSettingUseCase = GetSetting(settingRepository);
    final useCase = GetSholatSetting(getSettingUseCase);
    Setting setting = await useCase.execute();
    notifOn = setting.playAdzan;
  }

  Future<void> getQibla(Location location) async {
    final getQiblaUseCase = GetQibla(repository);
    var direction = await getQiblaUseCase.execute(location);
    if (direction > 180.000000000000) {
      direction = direction - 360;
    }
    arahKiblat = direction;
  }
}
