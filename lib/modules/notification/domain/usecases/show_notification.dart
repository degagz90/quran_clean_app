import '../repositories/local_notifications_repository.dart';

class ShowNotification {
  final LocalNotificationsRepository repository;
  ShowNotification(this.repository);

  Future<void> execute(String prayerName, DateTime prayerTime) async {
    await repository.showNotification(prayerName, prayerTime);
  }
}
