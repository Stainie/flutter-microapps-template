import 'package:notifications/domain/entities/notification.dart';
import 'package:notifications/datasource/dtos/notification_dto.dart';

extension NotificationMapper on NotificationDto {
  Notification toDomain() => Notification(
        id: id,
        title: title,
        body: body,
        isRead: isRead,
        screen: screen,
        parameter: parameter,
        redirectUrl: redirectUrl,
        createdDate: createDate,
      );
}
