import 'dart:async';

import 'package:crashlytics/crashlytics_service.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:result/result.dart';

class DeleteNotificationUsecase {
  DeleteNotificationUsecase({
    required this.notificationRepository,
    required this.crash,
  });

  static String crashlyticsLabelCall =
      'DeleteNotificationUsecase - Unable to delete notification';

  final NotificationRepository notificationRepository;
  final CrashlyticsService crash;

  Future<Result<NotificationError, bool>> call(int notificationId) async {
    try {
      return await notificationRepository.deleteNotification(notificationId);
    } catch (e, s) {
      unawaited(
        crash.logError(
          e,
          s,
          reason: crashlyticsLabelCall,
        ),
      );
      return Err(UnableToDeleteNotification());
    }
  }
}
