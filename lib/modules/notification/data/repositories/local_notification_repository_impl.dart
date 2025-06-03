import '../../domain/repositories/local_notifications_repository.dart';
import '../datasources/local_notifications_datasource.dart';

class LocalNotificationRepositoryImpl implements LocalNotificationsRepository {
  final notificationService = NotificationService();

  @override
  Future<void> showNotification(
    String prayerName,
    DateTime prayerTime,
    int id,
    String localZone,
  ) async {
    await notificationService.showNotification(
      prayerName,
      prayerTime,
      id,
      localZone,
    );
  }

  @override
  Future<void> cancelAllNotifications() async {
    await notificationService.cancelAllNotifications();
  }
}
