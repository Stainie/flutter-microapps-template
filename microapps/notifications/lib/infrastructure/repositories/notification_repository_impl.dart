import 'dart:async';

import 'package:crashlytics/crashlytics.dart';
import 'package:notifications/domain/entities/notification.dart';
import 'package:notifications/domain/entities/notification_user.dart';
import 'package:notifications/infrastructure/services/notification_service.dart';
import 'package:result/result.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({
    required this.notificationService,
    required this.crashlytics,
    required this.user,
  });

  final NotificationService notificationService;
  final CrashlyticsService crashlytics;
  final NotificationUser user;

  static String crashlyticsLabelSubscribeToPushNotifications =
      'NotificationRepositoryImpl - subscribeToPushNotifications';
  static String crashlyticsLabelDeleteNotification =
      'NotificationRepositoryImpl - deleteNotification';
  static String crashlyticsLabelChangeDeviceLanguage =
      'NotificationRepositoryImpl - changeDeviceLanguage';
  static String crashlyticsLabelGetNotifications =
      'NotificationRepositoryImpl - getNotifications';
  static String crashlyticsLabelPushNotificationsPermissionDenied =
      'NotificationRepositoryImpl - pushNotificationsPermissionDenied';
  static String crashlyticsLabelUnsubscribeFromPushNotifications =
      'NotificationRepositoryImpl - unsubscribeFromPushNotifications';
  static String crashlyticsLabelReadNotification =
      'NotificationRepositoryImpl - readNotification';

  @override
  Future<Result<NotificationError, bool>> subscribeToPushNotifications() async {
    try {
      return await notificationService.addNewDevice(user);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelSubscribeToPushNotifications,
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
      return await notificationService.deleteNotification(notificationId);
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
  Future<Result<NotificationError, bool>> changeDeviceLanguage() async {
    try {
      return await notificationService.editDevice(user);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelChangeDeviceLanguage,
        ),
      );
      return Err(UnableToChangeDeviceLanguage());
    }
  }

  @override
  Future<Result<NotificationError, List<Notification>>>
      getNotifications() async {
    try {
      return await notificationService.getNotifications();
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelGetNotifications,
        ),
      );
      return Err(UnableToGetNotifications());
    }
  }

  @override
  Future<Result<NotificationError, bool>>
      pushNotificationsPermissionDenied() async {
    try {
      return await notificationService.addNewUser(user);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelPushNotificationsPermissionDenied,
        ),
      );
      return Err(FailureDueToDisablingPushNotifications());
    }
  }

  @override
  Future<Result<NotificationError, bool>>
      unsubscribeFromPushNotifications() async {
    try {
      return await notificationService.removeDevice();
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelUnsubscribeFromPushNotifications,
        ),
      );
      return Err(UnableToUnsubscribeFromPushNotifications());
    }
  }

  @override
  Future<Result<NotificationError, bool>> readNotification(
    int notificationId,
  ) async {
    try {
      return await notificationService.updateNotificationStatus(notificationId);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: crashlyticsLabelReadNotification,
        ),
      );
      return Err(UnableToMarkNotificationAsRead());
    }
  }
}
