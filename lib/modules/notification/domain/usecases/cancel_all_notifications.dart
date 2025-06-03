import '../repositories/local_notifications_repository.dart';

class CancelAllNotifications {
  final LocalNotificationsRepository repository;
  CancelAllNotifications(this.repository);

  Future<void> execute() async {
    await repository.cancelAllNotifications();
  }
}
