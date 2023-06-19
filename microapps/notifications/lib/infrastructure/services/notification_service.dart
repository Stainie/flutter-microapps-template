import 'package:notifications/domain/entities/notification.dart';
import 'package:notifications/domain/entities/notification_user.dart';
import 'package:result/result.dart';
import 'package:notifications/domain/errors/notification_errors.dart';

abstract class NotificationService {
  Future<Result<NotificationError, bool>> addNewDevice(NotificationUser user);
  Future<Result<NotificationError, bool>> addNewUser(NotificationUser user);
  Future<Result<NotificationError, bool>> editDevice(NotificationUser user);
  Future<Result<NotificationError, bool>> removeDevice();
  Future<Result<NotificationError, List<Notification>>> getNotifications();
  Future<Result<NotificationError, bool>> updateNotificationStatus(
    int notificationId,
  );
  Future<Result<NotificationError, bool>> deleteNotification(
    int notificationId,
  );
}
