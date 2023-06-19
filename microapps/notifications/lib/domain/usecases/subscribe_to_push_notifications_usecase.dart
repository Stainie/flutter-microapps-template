import 'dart:async';

import 'package:crashlytics/crashlytics.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:result/result.dart';

class SubscribeToPushNotificationsUsecase {
  SubscribeToPushNotificationsUsecase({
    required this.notificationRepository,
    required this.crash,
  });

  final NotificationRepository notificationRepository;
  final CrashlyticsService crash;

  static String crashlyticsLabelCall =
      'PushNotificationTurnedOnUsecase - Unable to subscribe to push notifications';

  Future<Result<NotificationError, bool>> call() async {
    try {
      return await notificationRepository.subscribeToPushNotifications();
    } catch (e, s) {
      unawaited(
        crash.logError(
          e,
          s,
          reason: crashlyticsLabelCall,
        ),
      );
      return Err(UnableToSubscribeToPushNotifications());
    }
  }
}
