import 'dart:async';

import 'package:crashlytics/crashlytics_service.dart';
import 'package:result/result.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';

class UnsubscribeFromPushNotificationsUsecase {
  UnsubscribeFromPushNotificationsUsecase({
    required this.notificationRepository,
    required this.crash,
  });

  final NotificationRepository notificationRepository;
  final CrashlyticsService crash;

  static String crashlyticsLabelCall =
      'PushNotificationsTurnedOffUsecase - Unable to unsubscribe from push notifications';

  Future<Result<NotificationError, bool>> call() async {
    try {
      return await notificationRepository.unsubscribeFromPushNotifications();
    } catch (e, s) {
      unawaited(
        crash.logError(
          e,
          s,
          reason: crashlyticsLabelCall,
        ),
      );
      return Err(UnableToUnsubscribeFromPushNotifications());
    }
  }
}
