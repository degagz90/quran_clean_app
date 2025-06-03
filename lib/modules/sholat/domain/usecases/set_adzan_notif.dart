import 'package:quran_clean/modules/notification/domain/usecases/show_notification.dart';

class SetAdzanNotif {
  final ShowNotification showNotificationUseCase;
  SetAdzanNotif(this.showNotificationUseCase);

  Future<void> execute(
    String prayerName,
    DateTime prayerTime,
    int id,
    String localZone,
  ) async {
    await showNotificationUseCase.execute(
      prayerName,
      prayerTime,
      id,
      localZone,
    );
  }
}
