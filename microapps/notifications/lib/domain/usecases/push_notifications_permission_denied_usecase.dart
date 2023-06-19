import 'dart:async';

import 'package:crashlytics/crashlytics_service.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:result/result.dart';

class PushNotificationsPermissionDeniedUsecase {
  PushNotificationsPermissionDeniedUsecase({
    required this.notificationRepository,
    required this.crash,
  });

  final NotificationRepository notificationRepository;
  final CrashlyticsService crash;

  static String crashlyticsLabelCall =
      'PushNotificationsPermissionDeniedUsecase - failure due to disabling push notifications';

  Future<Result<NotificationError, bool>> call() async {
    try {
      return await notificationRepository.pushNotificationsPermissionDenied();
    } catch (e, s) {
      unawaited(
        crash.logError(
          e,
          s,
          reason: crashlyticsLabelCall,
        ),
      );
      return Err(FailureDueToDisablingPushNotifications());
    }
  }
}
