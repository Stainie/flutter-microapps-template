import 'package:local_storage/json.dart';
import 'package:local_storage/serializable.dart';

class Notification with BiSerializable<Notification> {
  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.screen,
    required this.parameter,
    required this.redirectUrl,
    required this.createdDate,
  });

  final int id;
  final String title;
  final String body;
  final bool isRead;
  final String screen;
  final String parameter;
  final String redirectUrl;
  final String createdDate;

  @override
  Notification fromJson(Json json) => Notification(
        id: json.readInt('id') ?? 0,
        title: json.readString('title') ?? '',
        body: json.readString('body') ?? '',
        isRead: json.readBool('isRead') ?? false,
        screen: json.readString('screen') ?? '',
        parameter: json.readString('parameter') ?? '',
        redirectUrl: json.readString('redirectUrl') ?? '',
        createdDate: json.readString('createdDate') ?? '',
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'isRead': isRead,
        'screen': screen,
        'parameter': parameter,
        'redirectUrl': redirectUrl,
        'createdDate': createdDate,
      };
}

class NotificationPayload with BiSerializable<NotificationPayload> {
  NotificationPayload({
    this.redirectScreen,
    this.parameter,
    this.notificationId,
  });

  final String? redirectScreen;
  final String? parameter;
  final int? notificationId;

  @override
  NotificationPayload fromJson(Json json) => NotificationPayload(
        redirectScreen: json.readString('redirectScreen'),
        parameter: json.readString('parameter'),
        notificationId: json.readInt('notificationId'),
      );

  @override
  Map<String, dynamic> toJson() => {
        'redirectScreen': redirectScreen,
        'parameter': parameter,
        'notificationId': notificationId,
      };
}
