import 'package:local_storage/json.dart';
import 'package:local_storage/serializable.dart';

class NotificationUser with BiSerializable<NotificationUser> {
  NotificationUser({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;
  final String lastName;

  @override
  NotificationUser fromJson(Json json) {
    // TODO(marko): implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO(marko): implement toJson
    throw UnimplementedError();
  }
}
