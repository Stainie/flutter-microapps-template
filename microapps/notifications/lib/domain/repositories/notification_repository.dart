import 'package:notifications/domain/entities/notification.dart';
import 'package:result/result.dart';
import 'package:notifications/domain/errors/notification_errors.dart';

abstract class NotificationRepository {
  Future<Result<NotificationError, bool>> subscribeToPushNotifications();
  Future<Result<NotificationError, bool>> pushNotificationsPermissionDenied();
  Future<Result<NotificationError, bool>> changeDeviceLanguage();
  Future<Result<NotificationError, bool>> unsubscribeFromPushNotifications();
  Future<Result<NotificationError, List<Notification>>> getNotifications();
  Future<Result<NotificationError, bool>> readNotification(int notificationId);
  Future<Result<NotificationError, bool>> deleteNotification(
    int notificationId,
  );
}
