library push_notifications;

abstract class PushNotifications {
  Future<bool?> requestPermission();
  Future<String?> getToken();
  Future<void> setup();
}
