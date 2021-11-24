import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin
  =FlutterLocalNotificationsPlugin();
  static void initialize() {
    final InitializationSettings initializationSettings=
    InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings);

  }
  static Future<void> display(RemoteMessage message) async {
    try {
      final id = Random().nextInt(100);
      final NotificationDetails notificationDetails=NotificationDetails(
        android: AndroidNotificationDetails(
          "default_notification_channel_id",
          "fcm_default_channel",
          importance: Importance.max,
          priority: Priority.high,
        )
      );
      await _notificationsPlugin.show(
          id, message.notification!.title,
          message.notification!.body,
          notificationDetails,
      );

    } on Exception catch (e) {
        print("error print: ${e.toString()}");
    }
  }
}