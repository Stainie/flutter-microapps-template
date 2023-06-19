import 'dart:async';

import 'package:crashlytics/crashlytics_service.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:result/result.dart';

class ReadNotificationUsecase {
  ReadNotificationUsecase({
    required this.notificationRepository,
    required this.crash,
  });

  final NotificationRepository notificationRepository;
  final CrashlyticsService crash;

  static String crashlyticsLabelCall =
      'ReadNotificationUsecase - Unable to mark notification as read';

  Future<Result<NotificationError, bool>> call(int notificationId) async {
    try {
      return await notificationRepository.readNotification(notificationId);
    } catch (e, s) {
      unawaited(
        crash.logError(
          e,
          s,
          reason: crashlyticsLabelCall,
        ),
      );
      return Err(UnableToMarkNotificationAsRead());
    }
  }
}
