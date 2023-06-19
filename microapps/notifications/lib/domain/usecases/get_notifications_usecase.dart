import 'dart:async';

import 'package:crashlytics/crashlytics_service.dart';
import 'package:notifications/domain/entities/notification.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:result/result.dart';

class GetNotificationsUseCase {
  GetNotificationsUseCase({
    required this.notificationRepository,
    required this.crash,
  });

  final NotificationRepository notificationRepository;
  final CrashlyticsService crash;

  static String crashlyticsLabelCall =
      'GetNotificationsUseCase - Unable to get notifications';

  Future<Result<NotificationError, List<Notification>>> call() async {
    try {
      return await notificationRepository.getNotifications();
    } catch (e, s) {
      unawaited(
        crash.logError(
          e,
          s,
          reason: crashlyticsLabelCall,
        ),
      );
      return Err(UnableToGetNotifications());
    }
  }
}
