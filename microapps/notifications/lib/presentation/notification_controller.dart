import 'dart:async';

import 'package:crashlytics/crashlytics.dart';
import 'package:notifications/domain/entities/notification.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/usecases/change_device_language_usecase.dart';
import 'package:notifications/domain/usecases/delete_notification_usecase.dart';
import 'package:notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:notifications/domain/usecases/push_notifications_permission_denied_usecase.dart';
import 'package:notifications/domain/usecases/read_notification_usecase.dart';
import 'package:notifications/domain/usecases/subscribe_to_push_notifications_usecase.dart';
import 'package:notifications/domain/usecases/unsubscribe_from_push_notifications_usecase.dart';
import 'package:result/result.dart';

class NotificationController {
  NotificationController(
    this._subscribeToPushNotificationsUsecase,
    this._unsubscribeFromPushNotificationsUsecase,
    this._readNotificationUsecase,
    this._permissionDeniedUsecase,
    this._getNotificationsUseCase,
    this._deleteNotificationUsecase,
    this._changeDeviceLanguageUsecase,
    this._crash,
  );

  final SubscribeToPushNotificationsUsecase
      _subscribeToPushNotificationsUsecase;
  final UnsubscribeFromPushNotificationsUsecase
      _unsubscribeFromPushNotificationsUsecase;
  final ReadNotificationUsecase _readNotificationUsecase;
  final PushNotificationsPermissionDeniedUsecase _permissionDeniedUsecase;
  final GetNotificationsUseCase _getNotificationsUseCase;
  final DeleteNotificationUsecase _deleteNotificationUsecase;
  final ChangeDeviceLanguageUsecase _changeDeviceLanguageUsecase;
  final CrashlyticsService _crash;

  static String crashlyticsLabelSubscribeToPushNotifications =
      'NotificationController - Unable to subscribe to push notifications';
  static String crashlyticsLabelUnsubscribeFromPushNotifications =
      'NotificationController - Unable to unsubscribe from push notifications';
  static String crashlyticsLabelChangeDeviceLanguage =
      'NotificationController - Unable to change device language';
  static String crashlyticsLabelPermissionDenied =
      'NotificationController - Failure due to disabling push notifications permission';
  static String crashlyticsLabelGetNotifications =
      'NotificationController - Unable to get notifications';
  static String crashlyticsLabelDeleteNotification =
      'NotificationController - Unable to delete notifications';
  static String crashlyticsLabelMarkNotificationAsRead =
      'NotificationController - Unable to mark notification as read';

  Future<Result<NotificationError, bool>> subscribeToPushNotifications() async {
    try {
      final result = await _subscribeToPushNotificationsUsecase.call();

      if (result.isErr) {
        return result;
      }

      return const Ok(true);
    } catch (e, s) {
      unawaited(
        _crash.logError(
          e,
          s,
          reason: crashlyticsLabelSubscribeToPushNotifications,
        ),
      );
      return Err(UnableToSubscribeToPushNotifications());
    }
  }

  Future<Result<NotificationError, bool>>
      unsubscribeFromPushNotifications() async {
    try {
      final result = await _unsubscribeFromPushNotificationsUsecase.call();

      if (result.isErr) {
        return result;
      }

      return const Ok(true);
    } catch (e, s) {
      unawaited(
        _crash.logError(
          e,
          s,
          reason: crashlyticsLabelUnsubscribeFromPushNotifications,
        ),
      );
      return Err(UnableToUnsubscribeFromPushNotifications());
    }
  }

  Future<Result<NotificationError, bool>> changeDeviceLanguage() async {
    try {
      final result = await _changeDeviceLanguageUsecase.call();

      if (result.isErr) {
        return result;
      }

      return const Ok(true);
    } catch (e, s) {
      unawaited(
        _crash.logError(
          e,
          s,
          reason: crashlyticsLabelChangeDeviceLanguage,
        ),
      );
      return Err(UnableToChangeDeviceLanguage());
    }
  }

  Future<Result<NotificationError, bool>> permissionDenied() async {
    try {
      final result = await _permissionDeniedUsecase.call();

      if (result.isErr) {
        return result;
      }

      return const Ok(true);
    } catch (e, s) {
      unawaited(
        _crash.logError(
          e,
          s,
          reason: crashlyticsLabelPermissionDenied,
        ),
      );
      return Err(FailureDueToDisablingPushNotifications());
    }
  }

  Future<Result<NotificationError, List<Notification>>>
      getNotifications() async {
    try {
      final result = await _getNotificationsUseCase.call();

      if (result.isErr) {
        return result;
      }
      final list = <Notification>[];
      return Ok(list);
    } catch (e, s) {
      unawaited(
        _crash.logError(
          e,
          s,
          reason: crashlyticsLabelGetNotifications,
        ),
      );
      return Err(FailureDueToDisablingPushNotifications());
    }
  }

  Future<Result<NotificationError, bool>> deleteNotification(
    int notificationId,
  ) async {
    try {
      final result = await _deleteNotificationUsecase.call(notificationId);

      if (result.isErr) {
        return result;
      }

      return const Ok(true);
    } catch (e, s) {
      unawaited(
        _crash.logError(
          e,
          s,
          reason: crashlyticsLabelDeleteNotification,
        ),
      );
      return Err(UnableToDeleteNotification());
    }
  }

  Future<Result<NotificationError, bool>> markNotificationAsRead(
    int notificationId,
  ) async {
    try {
      final result = await _readNotificationUsecase.call(notificationId);

      if (result.isErr) {
        return result;
      }

      return const Ok(true);
    } catch (e, s) {
      unawaited(
        _crash.logError(
          e,
          s,
          reason: crashlyticsLabelMarkNotificationAsRead,
        ),
      );
      return Err(UnableToMarkNotificationAsRead());
    }
  }
}
