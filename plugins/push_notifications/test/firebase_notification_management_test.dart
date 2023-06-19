import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:push_notifications/firebase_notification_management.dart';

import 'firebase_notification_management_test.mocks.dart';

@GenerateMocks([
  FirebaseMessaging,
])
void main() {
  late FirebaseMessaging firebaseMessaging;
  late FirebaseNotificationManagement firebaseNotificationManagement;

  setUp(() {
    firebaseMessaging = MockFirebaseMessaging();
    firebaseNotificationManagement = FirebaseNotificationManagement(
      firebaseMessaging: firebaseMessaging,
      onMessage: () {},
      onMessageOpenedApp: () {},
      onTokenRefresh: () {},
      onBackgroundMessage: () {},
    );
  });

  group('FirebaseNotificationManagement', () {
    test('requestPermission() happy flow', () async {
      when(firebaseMessaging.requestPermission()).thenAnswer(
        (_) async => const NotificationSettings(
          authorizationStatus: AuthorizationStatus.authorized,
          alert: AppleNotificationSetting.enabled,
          announcement: AppleNotificationSetting.enabled,
          badge: AppleNotificationSetting.enabled,
          carPlay: AppleNotificationSetting.enabled,
          criticalAlert: AppleNotificationSetting.enabled,
          lockScreen: AppleNotificationSetting.enabled,
          notificationCenter: AppleNotificationSetting.enabled,
          showPreviews: AppleShowPreviewSetting.always,
          sound: AppleNotificationSetting.enabled,
          timeSensitive: AppleNotificationSetting.enabled,
        ),
      );

      expect(await firebaseNotificationManagement.requestPermission(), true);
    });

    test('requestPermission() authorization status unauthorized', () async {
      when(firebaseMessaging.requestPermission()).thenAnswer(
        (_) async => const NotificationSettings(
          authorizationStatus: AuthorizationStatus.denied,
          alert: AppleNotificationSetting.enabled,
          announcement: AppleNotificationSetting.enabled,
          badge: AppleNotificationSetting.enabled,
          carPlay: AppleNotificationSetting.enabled,
          criticalAlert: AppleNotificationSetting.enabled,
          lockScreen: AppleNotificationSetting.enabled,
          notificationCenter: AppleNotificationSetting.enabled,
          showPreviews: AppleShowPreviewSetting.always,
          sound: AppleNotificationSetting.enabled,
          timeSensitive: AppleNotificationSetting.enabled,
        ),
      );

      expect(await firebaseNotificationManagement.requestPermission(), false);
    });

    test('getToken() happy flow', () async {
      const token = 'token';
      when(firebaseMessaging.getToken()).thenAnswer((_) async => token);

      expect(await firebaseNotificationManagement.getToken(), token);
    });

    test('getToken() token is cached', () async {
      const oldToken = 'token1';
      const newToken = 'token2';

      when(firebaseMessaging.getToken()).thenAnswer((_) async => oldToken);
      expect(await firebaseNotificationManagement.getToken(), oldToken);

      // Now change the resulting token, but the cached token should still be
      // returned.
      when(firebaseMessaging.getToken()).thenAnswer((_) async => newToken);
      expect(await firebaseNotificationManagement.getToken(), oldToken);
    });

    // TODO(iannis & marko): Add tests for setup().
    // test(
    //   'setup() onTokenRefresh() is called when token is refreshed',
    //   () async {
    //     const firstRefreshedToken = 'token1';
    //     const secondRefreshedToken = 'token2';

    //     when(firebaseMessaging.getInitialMessage()).thenAnswer(
    //       (_) async => null,
    //     );

    //     when(firebaseMessaging.onTokenRefresh).thenAnswer(
    //       (_) => Stream<String>.fromIterable([
    //         firstRefreshedToken,
    //         secondRefreshedToken,
    //       ]),
    //     );

    //     await firebaseNotificationManagement.setup();

    //     expect(
    //       firebaseNotificationManagement.onTokenRefresh,
    //       emitsInOrder([
    //         firstRefreshedToken,
    //         secondRefreshedToken,
    //       ]),
    //     );
    //   },
    // );
  });
}
