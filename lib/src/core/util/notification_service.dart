import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static const String notificationIcon = 'ic_popcorn';
  static const String notificationId = 'movie favorites id';
  NotificationService();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(notificationIcon);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotifications.initialize(initializationSettings);
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'movie favorites id',
      'movie favorites channel',
      channelDescription: 'channel description',
      priority: Priority.high,
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('notification'),
      ticker: 'Ticker',
      onlyAlertOnce: true,
      visibility: NotificationVisibility.secret,
      color: const Color(0xff2196f3),
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    return platformChannelSpecifics;
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final NotificationDetails platformChannelSpecifics =
        await _notificationDetails();
    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
