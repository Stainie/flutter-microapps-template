import 'package:crashlytics/crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/usecases/change_device_language_usecase.dart';
import 'package:notifications/domain/usecases/delete_notification_usecase.dart';
import 'package:notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:notifications/domain/usecases/push_notifications_permission_denied_usecase.dart';
import 'package:notifications/domain/usecases/read_notification_usecase.dart';
import 'package:notifications/domain/usecases/subscribe_to_push_notifications_usecase.dart';
import 'package:notifications/domain/usecases/unsubscribe_from_push_notifications_usecase.dart';
import 'package:notifications/presentation/notification_controller.dart';
import 'package:result/result.dart';

import 'notification_controller_test.mocks.dart';

@GenerateMocks([
  SubscribeToPushNotificationsUsecase,
  UnsubscribeFromPushNotificationsUsecase,
  ReadNotificationUsecase,
  PushNotificationsPermissionDeniedUsecase,
  GetNotificationsUseCase,
  DeleteNotificationUsecase,
  ChangeDeviceLanguageUsecase,
  CrashlyticsService,
])
void main() {
  late MockSubscribeToPushNotificationsUsecase
      subscribeToPushNotificationsUsecase;
  late MockUnsubscribeFromPushNotificationsUsecase
      unsubscribeFromPushNotificationsUsecase;
  late MockReadNotificationUsecase readNotificationUsecase;
  late MockPushNotificationsPermissionDeniedUsecase permissionDeniedUsecase;
  late MockGetNotificationsUseCase getNotificationsUseCase;
  late MockDeleteNotificationUsecase deleteNotificationUsecase;
  late MockChangeDeviceLanguageUsecase changeDeviceLanguageUsecase;
  late MockCrashlyticsService crashlytics;
  late NotificationController controller;

  setUp(() {
    subscribeToPushNotificationsUsecase =
        MockSubscribeToPushNotificationsUsecase();
    unsubscribeFromPushNotificationsUsecase =
        MockUnsubscribeFromPushNotificationsUsecase();
    readNotificationUsecase = MockReadNotificationUsecase();
    permissionDeniedUsecase = MockPushNotificationsPermissionDeniedUsecase();
    getNotificationsUseCase = MockGetNotificationsUseCase();
    deleteNotificationUsecase = MockDeleteNotificationUsecase();
    changeDeviceLanguageUsecase = MockChangeDeviceLanguageUsecase();
    crashlytics = MockCrashlyticsService();
    controller = NotificationController(
      subscribeToPushNotificationsUsecase,
      unsubscribeFromPushNotificationsUsecase,
      readNotificationUsecase,
      permissionDeniedUsecase,
      getNotificationsUseCase,
      deleteNotificationUsecase,
      changeDeviceLanguageUsecase,
      crashlytics,
    );
  });

  group('NotificationController', () {
    const notifId = 123;

    group('subscribeToPushNotifications()', () {
      test('happy flow', () async {
        when(subscribeToPushNotificationsUsecase.call()).thenAnswer(
          (_) async => const Ok(true),
        );

        final result = await controller.subscribeToPushNotifications();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('error returned by usecase', () async {
        when(subscribeToPushNotificationsUsecase.call()).thenAnswer(
          (_) async => Err(UnableToSubscribeToPushNotifications()),
        );

        final result = await controller.subscribeToPushNotifications();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToSubscribeToPushNotifications>());
      });

      test('usecase throws error', () async {
        when(subscribeToPushNotificationsUsecase.call()).thenThrow(
          Exception('test'),
        );

        final result = await controller.subscribeToPushNotifications();

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationController
                .crashlyticsLabelSubscribeToPushNotifications,
          ),
        ).called(1);
      });
    });

    group('unsubscribeFromPushNotifications()', () {
      test('happy flow', () async {
        when(unsubscribeFromPushNotificationsUsecase.call()).thenAnswer(
          (_) async => const Ok(true),
        );

        final result = await controller.unsubscribeFromPushNotifications();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('error returned by usecase', () async {
        when(unsubscribeFromPushNotificationsUsecase.call()).thenAnswer(
          (_) async => Err(UnableToUnsubscribeFromPushNotifications()),
        );

        final result = await controller.unsubscribeFromPushNotifications();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToUnsubscribeFromPushNotifications>());
      });

      test('usecase throws error', () async {
        when(unsubscribeFromPushNotificationsUsecase.call()).thenThrow(
          Exception('test'),
        );

        final result = await controller.unsubscribeFromPushNotifications();

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationController
                .crashlyticsLabelUnsubscribeFromPushNotifications,
          ),
        ).called(1);
      });
    });

    group('changeDeviceLanguage()', () {
      test('happy flow', () async {
        when(changeDeviceLanguageUsecase.call()).thenAnswer(
          (_) async => const Ok(true),
        );

        final result = await controller.changeDeviceLanguage();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('error returned by usecase', () async {
        when(changeDeviceLanguageUsecase.call()).thenAnswer(
          (_) async => Err(UnableToChangeDeviceLanguage()),
        );

        final result = await controller.changeDeviceLanguage();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToChangeDeviceLanguage>());
      });

      test('usecase throws error', () async {
        when(changeDeviceLanguageUsecase.call()).thenThrow(
          Exception('test'),
        );

        final result = await controller.changeDeviceLanguage();

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationController.crashlyticsLabelChangeDeviceLanguage,
          ),
        ).called(1);
      });
    });

    group('permissionDenied()', () {
      test('happy flow', () async {
        when(permissionDeniedUsecase.call()).thenAnswer(
          (_) async => const Ok(true),
        );

        final result = await controller.permissionDenied();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('error returned by usecase', () async {
        when(permissionDeniedUsecase.call()).thenAnswer(
          (_) async => Err(FailureDueToDisablingPushNotifications()),
        );

        final result = await controller.permissionDenied();

        expect(result.isErr, true);
        expect(result.err, isA<FailureDueToDisablingPushNotifications>());
      });

      test('usecase throws error', () async {
        when(permissionDeniedUsecase.call()).thenThrow(
          Exception('test'),
        );

        final result = await controller.permissionDenied();

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationController.crashlyticsLabelPermissionDenied,
          ),
        ).called(1);
      });
    });

    group('getNotifications()', () {
      test('happy flow', () async {
        when(getNotificationsUseCase.call()).thenAnswer(
          (_) async => const Ok([]),
        );

        final result = await controller.getNotifications();

        expect(result.isOk, true);
        expect(result.ok.isEmpty, true);
      });

      test('error returned by usecase', () async {
        when(getNotificationsUseCase.call()).thenAnswer(
          (_) async => Err(UnableToGetNotifications()),
        );

        final result = await controller.getNotifications();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToGetNotifications>());
      });

      test('usecase throws error', () async {
        when(getNotificationsUseCase.call()).thenThrow(
          Exception('test'),
        );

        final result = await controller.getNotifications();

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationController.crashlyticsLabelGetNotifications,
          ),
        ).called(1);
      });
    });

    group('deleteNotification()', () {
      test('happy flow', () async {
        when(deleteNotificationUsecase.call(notifId)).thenAnswer(
          (_) async => const Ok(true),
        );

        final result = await controller.deleteNotification(notifId);

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('error returned by usecase', () async {
        when(deleteNotificationUsecase.call(notifId)).thenAnswer(
          (_) async => Err(UnableToDeleteNotification()),
        );

        final result = await controller.deleteNotification(notifId);

        expect(result.isErr, true);
        expect(result.err, isA<UnableToDeleteNotification>());
      });

      test('usecase throws error', () async {
        when(deleteNotificationUsecase.call(notifId)).thenThrow(
          Exception('test'),
        );

        final result = await controller.deleteNotification(notifId);

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationController.crashlyticsLabelDeleteNotification,
          ),
        ).called(1);
      });
    });

    group('markNotificationAsRead()', () {
      test('happy flow', () async {
        when(readNotificationUsecase.call(notifId)).thenAnswer(
          (_) async => const Ok(true),
        );

        final result = await controller.markNotificationAsRead(notifId);

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('error returned by usecase', () async {
        when(readNotificationUsecase.call(notifId)).thenAnswer(
          (_) async => Err(UnableToMarkNotificationAsRead()),
        );

        final result = await controller.markNotificationAsRead(notifId);

        expect(result.isErr, true);
        expect(result.err, isA<UnableToMarkNotificationAsRead>());
      });

      test('usecase throws error', () async {
        when(readNotificationUsecase.call(notifId)).thenThrow(
          Exception('test'),
        );

        final result = await controller.markNotificationAsRead(notifId);

        expect(result.isErr, true);
        expect(result.err, isA<Exception>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason:
                NotificationController.crashlyticsLabelMarkNotificationAsRead,
          ),
        ).called(1);
      });
    });
  });
}
