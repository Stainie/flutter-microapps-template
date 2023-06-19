import 'package:crashlytics/crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notifications/domain/entities/notification_user.dart';
import 'package:notifications/infrastructure/repositories/notification_repository_impl.dart';
import 'package:notifications/infrastructure/services/notification_service.dart';
import 'package:result/result.dart';

import 'notification_repository_impl_test.mocks.dart';

@GenerateMocks([
  NotificationService,
  CrashlyticsService,
])
void main() {
  late MockNotificationService notificationService;
  late MockCrashlyticsService crashlytics;
  late NotificationRepositoryImpl repository;

  group('NotificationRepositoryImpl', () {
    final user = NotificationUser(
      firstName: 'Rick',
      lastName: 'Astley',
    );

    const notifId = 123;

    setUp(() {
      notificationService = MockNotificationService();
      crashlytics = MockCrashlyticsService();
      repository = NotificationRepositoryImpl(
        notificationService: notificationService,
        crashlytics: crashlytics,
        user: user,
      );
    });

    group('subscribeToPushNotifications()', () {
      test('happy flow', () async {
        when(notificationService.addNewDevice(user))
            .thenAnswer((_) async => const Ok(true));

        final result = await repository.subscribeToPushNotifications();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('exception thrown', () async {
        when(notificationService.addNewDevice(user))
            .thenThrow((_) async => Err(Exception('test')));

        final result = await repository.subscribeToPushNotifications();

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationRepositoryImpl
                .crashlyticsLabelSubscribeToPushNotifications,
          ),
        ).called(1);
      });
    });

    group('deleteNotification()', () {
      test('happy flow', () async {
        when(notificationService.deleteNotification(notifId))
            .thenAnswer((_) async => const Ok(true));

        final result = await repository.deleteNotification(notifId);

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('exception thrown', () async {
        when(notificationService.deleteNotification(notifId))
            .thenThrow((_) async => Err(Exception('test')));

        final result = await repository.deleteNotification(notifId);

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason:
                NotificationRepositoryImpl.crashlyticsLabelDeleteNotification,
          ),
        ).called(1);
      });
    });

    group('changeDeviceLanguage()', () {
      test('happy flow', () async {
        when(notificationService.editDevice(user))
            .thenAnswer((_) async => const Ok(true));

        final result = await repository.changeDeviceLanguage();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('exception thrown', () async {
        when(notificationService.editDevice(user))
            .thenThrow((_) async => Err(Exception('test')));

        final result = await repository.changeDeviceLanguage();

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason:
                NotificationRepositoryImpl.crashlyticsLabelChangeDeviceLanguage,
          ),
        ).called(1);
      });
    });

    group('getNotifications()', () {
      test('happy flow', () async {
        when(notificationService.getNotifications())
            .thenAnswer((_) async => const Ok([]));

        final result = await repository.getNotifications();

        expect(result.isOk, true);
        expect(result.ok, []);
      });

      test('exception thrown', () async {
        when(notificationService.getNotifications())
            .thenThrow((_) async => Err(Exception('test')));

        final result = await repository.getNotifications();

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationRepositoryImpl.crashlyticsLabelGetNotifications,
          ),
        ).called(1);
      });
    });

    group('pushNotificationsPermissionDenied()', () {
      test('happy flow', () async {
        when(notificationService.addNewUser(user))
            .thenAnswer((_) async => const Ok(true));

        final result = await repository.pushNotificationsPermissionDenied();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('exception thrown', () async {
        when(notificationService.addNewUser(user))
            .thenThrow((_) async => Err(Exception('test')));

        final result = await repository.pushNotificationsPermissionDenied();

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationRepositoryImpl
                .crashlyticsLabelPushNotificationsPermissionDenied,
          ),
        ).called(1);
      });
    });

    group('unsubscribeFromPushNotifications()', () {
      test('happy flow', () async {
        when(notificationService.removeDevice())
            .thenAnswer((_) async => const Ok(true));

        final result = await repository.unsubscribeFromPushNotifications();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('exception thrown', () async {
        when(notificationService.removeDevice())
            .thenThrow((_) async => Err(Exception('test')));

        final result = await repository.unsubscribeFromPushNotifications();

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationRepositoryImpl
                .crashlyticsLabelUnsubscribeFromPushNotifications,
          ),
        ).called(1);
      });
    });

    group('readNotification()', () {
      test('happy flow', () async {
        when(notificationService.updateNotificationStatus(notifId))
            .thenAnswer((_) async => const Ok(true));

        final result = await repository.readNotification(notifId);

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('exception thrown', () async {
        when(notificationService.updateNotificationStatus(notifId))
            .thenThrow((_) async => Err(Exception('test')));

        final result = await repository.readNotification(notifId);

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationRepositoryImpl.crashlyticsLabelReadNotification,
          ),
        ).called(1);
      });
    });
  });
}
