import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "package:timezone/timezone.dart" as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
            // Handle notification tap
          },
    );
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.areNotificationsEnabled();
  }

  Future<void> showNotification(
    String prayerName,
    DateTime prayerTime,
    int id,
    String localZone,
  ) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          '002',
          'Adzan',
          channelDescription: 'Notifikasi Adzan',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound(
            prayerName.toLowerCase().contains("subuh") ? "fajr_adzan" : "adzan",
          ),
          playSound: true,
          showWhen: true,
          fullScreenIntent: true,
        );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    final location = tz.getLocation(localZone);
    final localTime = tz.TZDateTime.from(prayerTime, location);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Adzan $prayerName',
      'Waktunya sholat $prayerName',
      localTime,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    debugPrint("Adzan $prayerName set, scheduled on $localTime");
  }

  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
    debugPrint("Notification has been reset");
  }
}
