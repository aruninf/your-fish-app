import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (Platform.isIOS) {
    await NotificationService.initialize();
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      NotificationService.show(
        notification.hashCode,
        notification.title!,
        notification.body!,
        message.data.toString(),
      );
    }
  }

  print('Handled background message ${message.messageId}');
}

Future<dynamic> _onSelectNotification(String? payload) async {}

class NotificationService {
  static bool _isInitialized = false;
  static late AndroidNotificationChannel channel;
  static late FlutterLocalNotificationsPlugin localNotifications;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    channel = const AndroidNotificationChannel(
      'yourfish_notifications',
      'yourfish_notifications',
      description: 'This channel is used for yourfish notifications',
      importance: Importance.max,
    );

    localNotifications = FlutterLocalNotificationsPlugin();

    await localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: IOSInitializationSettings()
      ),
      onSelectNotification: _onSelectNotification,
    );

    // Create an Android notification channel.
    //
    // We use this channel in the `AndroidManifest.xml` file to override the default FCM channel to enable heads up notifications.
    await localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    // Update the iOS foreground notification presentation options to allow heads up notifications
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await Firebase.initializeApp();

      // log that the user has opened the notification to firebase analytics
      _onSelectNotification(message.data.toString());
    });

    FirebaseMessaging.instance.subscribeToTopic("all");
    _isInitialized = true;
  }

  static void show(int id, String title, String body, String? payload) {
    localNotifications.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
        )
      ),
      payload: payload
    );
  }
}