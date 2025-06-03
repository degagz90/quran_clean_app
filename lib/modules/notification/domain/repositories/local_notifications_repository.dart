abstract class LocalNotificationsRepository {
  Future<void> showNotification(
    String prayerName,
    DateTime prayerTime,
    int id,
    String localZone,
  );
  Future<void> cancelAllNotifications();
}
