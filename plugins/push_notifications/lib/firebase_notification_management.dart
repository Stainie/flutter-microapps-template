import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notifications/push_notifications.dart';

class FirebaseNotificationManagement implements PushNotifications {
  FirebaseNotificationManagement({
    required this.onMessage,
    required this.onMessageOpenedApp,
    required this.onTokenRefresh,
    required this.onBackgroundMessage,
    required this.firebaseMessaging,
  });

  FirebaseNotificationManagement.create({
    required this.onMessage,
    required this.onMessageOpenedApp,
    required this.onTokenRefresh,
    required this.onBackgroundMessage,
  }) : firebaseMessaging = FirebaseMessaging.instance;

  final void Function() onMessage;
  final void Function() onMessageOpenedApp;
  final void Function() onTokenRefresh;
  final void Function() onBackgroundMessage;
  final FirebaseMessaging firebaseMessaging;

  String? _fcmToken;

  @override
  Future<bool?> requestPermission() async {
    final settings = await firebaseMessaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  Future<String?> getToken() async {
    if (_fcmToken != null) {
      return _fcmToken;
    }
    _fcmToken = await firebaseMessaging.getToken();
    debugPrint('fcmToken is $_fcmToken');
    return _fcmToken;
  }

  @override
  Future<void> setup() async {
    firebaseMessaging.onTokenRefresh.listen((newFcmToken) {
      if (newFcmToken == _fcmToken) {
        return;
      }
      _fcmToken = newFcmToken;
      onTokenRefresh();
    });

    // Handle messages while app is in the foreground
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('A new onMessage event was published with message:$message');
      onMessage();
    });
    // Handle user tap on push notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint(
        'A new onMessageOpenedApp event was published with message: $message',
      );
      onMessageOpenedApp();
    });

    // App is terminated and push notification arrives
    final message = await firebaseMessaging.getInitialMessage();
    debugPrint(message.toString());

    // Handle messages when app is in the background or terminated
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}

/// From [FirebaseMessaging.onBackgroundMessage] documentation:
/// This provided handler must be a top-level function and cannot be
/// anonymous otherwise an [ArgumentError] will be thrown.
/// DO NOT refactor this into a class method.
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  debugPrint('Handling a background message: ${message.messageId}');
}
