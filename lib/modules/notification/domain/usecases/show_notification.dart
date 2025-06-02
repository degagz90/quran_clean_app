import '../repositories/local_notifications_repository.dart';

class ShowNotification {
  final LocalNotificationsRepository repository;
  ShowNotification(this.repository);

  Future<void> execute(String prayerName) async {
    await repository.showNotification(prayerName);
  }
}
