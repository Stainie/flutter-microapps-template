import 'package:crashlytics/crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:notifications/domain/usecases/unsubscribe_from_push_notifications_usecase.dart';
import 'package:result/result.dart';

import 'unsubscribe_from_push_notifications_usecase_test.mocks.dart';

@GenerateMocks([
  NotificationRepository,
  CrashlyticsService,
])
void main() {
  late MockNotificationRepository notificationRepository;
  late MockCrashlyticsService crashlytics;
  late UnsubscribeFromPushNotificationsUsecase usecase;

  setUp(() {
    notificationRepository = MockNotificationRepository();
    crashlytics = MockCrashlyticsService();
    usecase = UnsubscribeFromPushNotificationsUsecase(
      notificationRepository: notificationRepository,
      crash: crashlytics,
    );
  });

  group('UnsubscribeFromPushNotificationsUsecase', () {
    group('call()', () {
      test('happy flow', () async {
        when(notificationRepository.unsubscribeFromPushNotifications())
            .thenAnswer(
          (_) async => const Ok(true),
        );

        final result = await usecase.call();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('error returned by repo', () async {
        when(notificationRepository.unsubscribeFromPushNotifications())
            .thenAnswer(
          (_) async => Err(UnableToUnsubscribeFromPushNotifications()),
        );

        final result = await usecase.call();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToUnsubscribeFromPushNotifications>());
      });

      test('repo throws error', () async {
        when(notificationRepository.unsubscribeFromPushNotifications())
            .thenThrow(
          Exception('test'),
        );

        final result = await usecase.call();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToUnsubscribeFromPushNotifications>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason:
                UnsubscribeFromPushNotificationsUsecase.crashlyticsLabelCall,
          ),
        ).called(1);
      });
    });
  });
}
