abstract class NotificationError implements Exception {
  String get message;
}

class UnableToSubscribeToPushNotifications implements NotificationError {
  @override
  String get message => 'Unable to subscribe to push notifications';
}

class FailureDueToDisablingPushNotifications implements NotificationError {
  @override
  String get message => 'Failed to disable push notifications';
}

class UnableToChangeDeviceLanguage implements NotificationError {
  @override
  String get message => 'Unable to change device language';
}

class UnableToUnsubscribeFromPushNotifications implements NotificationError {
  @override
  String get message => 'Unable to unsubscribe from push notifications';
}

class UnableToGetNotifications implements NotificationError {
  @override
  String get message => 'Unable to get notifications';
}

class UnableToMarkNotificationAsRead implements NotificationError {
  @override
  String get message => 'Unable to mark notification as read';
}

class UnableToDeleteNotification implements NotificationError {
  @override
  String get message => 'Unable to delete notification';
}
