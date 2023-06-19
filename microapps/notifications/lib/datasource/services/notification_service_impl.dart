import 'dart:async';

import 'package:crashlytics/crashlytics.dart';
import 'package:http_abstraction/http_abstraction.dart';
import 'package:notifications/domain/entities/notification.dart';
import 'package:notifications/domain/entities/notification_user.dart';
import 'package:result/result.dart';

import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/infrastructure/services/notification_service.dart';

class NotificationServiceImpl implements NotificationService {
  NotificationServiceImpl({
    required this.client,
    required this.crashlytics,
    required this.fcmToken,
  });

  final IHttpClient client;
  final CrashlyticsService crashlytics;
  final String fcmToken;

  // TODO(marko): Discuss where we place crashlytics log labels.
  static String crashlyticsLabelAddNewDevice =
      'NotificationServiceImpl - addNewDevice';
  static String crashlyticsLabelAddNewUser =
      'NotificationServiceImpl - addNewUser';
  static String crashlyticsLabelDeleteNotification =
      'NotificationServiceImpl - deleteNotification';
  static String crashlyticsLabelEditDevice =
      'NotificationServiceImpl - editDevice';
  static String crashlyticsLabelGetNotfications =
      'NotificationServiceImpl - getNotifications';
  static String crashlyticsLabelRemoveDevice =
      'NotificationServiceImpl - removeDevice';
  static String crashlyticsLabelUpdateNotificationStatus =
      'NotificationServiceImpl - updateNotificationStatus';

  @override
  Future<Result<NotificationError, bool>> addNewDevice(
    NotificationUser user,
  ) async {
    try {
      final jsonBody = HttpBodyJson({
        'token': fcmToken,
        'userFirstName': user.firstName,
        'userLastName': user.lastName,
      });
      final response = await client.post(
        endpoint: 'v1/device',
        body: jsonBody,
      );
      if (response.isErr) {
        return Err(UnableToSubscribeToPushNotifications());
      }
      return const Ok(true);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelAddNewDevice,
        ),
      );
      return Err(UnableToSubscribeToPushNotifications());
    }
  }

  @override
  Future<Result<NotificationError, bool>> addNewUser(
    NotificationUser user,
  ) async {
    try {
      final jsonBody = HttpBodyJson({
        'firstName': user.firstName,
        'lastName': user.lastName,
      });
      final response = await client.post(
        endpoint: 'v1/user',
        body: jsonBody,
      );
      if (response.isErr) {
        return Err(UnableToSubscribeToPushNotifications());
      }
      return const Ok(true);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelAddNewUser,
        ),
      );
      return Err(UnableToSubscribeToPushNotifications());
    }
  }

  @override
  Future<Result<NotificationError, bool>> deleteNotification(
    int notificationId,
  ) async {
    try {
      final response = await client.delete(
        endpoint: 'v1/notification?notificationId=$notificationId',
      );
      if (response.isErr) {
        return Err(UnableToDeleteNotification());
      }
      return const Ok(true);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelDeleteNotification,
        ),
      );
      return Err(UnableToDeleteNotification());
    }
  }

  @override
  Future<Result<NotificationError, bool>> editDevice(
    NotificationUser user,
  ) async {
    try {
      final jsonBody = HttpBodyJson({
        'token': fcmToken,
        'userFirstName': user.firstName,
        'userLastName': user.lastName,
      });
      final response = await client.put(
        endpoint: 'v1/device',
        body: jsonBody,
      );
      if (response.isErr) {
        return Err(UnableToChangeDeviceLanguage());
      }
      return const Ok(true);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelEditDevice,
        ),
      );
      return Err(UnableToChangeDeviceLanguage());
    }
  }

  @override
  Future<Result<NotificationError, List<Notification>>>
      getNotifications() async {
    try {
      final response = await client.get(endpoint: 'v1/notification');
      if (response.isErr) {
        return Err(UnableToGetNotifications());
      }
      // TODO(marko): return type should be updated
      final list = <Notification>[];
      return Ok(list);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelGetNotfications,
        ),
      );
      return Err(UnableToGetNotifications());
    }
  }

  @override
  Future<Result<NotificationError, bool>> removeDevice() async {
    try {
      final jsonBody = HttpBodyJson({
        'token': fcmToken,
      });
      final response = await client.delete(
        endpoint: 'v1/device',
        body: jsonBody,
      );
      if (response.isErr) {
        return Err(UnableToUnsubscribeFromPushNotifications());
      }
      return const Ok(true);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelRemoveDevice,
        ),
      );
      return Err(UnableToUnsubscribeFromPushNotifications());
    }
  }

  @override
  Future<Result<NotificationError, bool>> updateNotificationStatus(
    int notificationId,
  ) async {
    try {
      final response = await client.patch(
        endpoint: 'v1/notification?notificationId=$notificationId',
      );
      if (response.isErr) {
        return Err(UnableToMarkNotificationAsRead());
      }
      return const Ok(true);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelUpdateNotificationStatus,
        ),
      );
      return Err(UnableToMarkNotificationAsRead());
    }
  }
}
