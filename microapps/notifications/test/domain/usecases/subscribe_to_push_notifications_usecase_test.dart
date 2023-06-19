import 'package:crashlytics/crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:notifications/domain/usecases/subscribe_to_push_notifications_usecase.dart';
import 'package:result/result.dart';

import 'subscribe_to_push_notifications_usecase_test.mocks.dart';

@GenerateMocks([
  NotificationRepository,
  CrashlyticsService,
])
void main() {
  late MockNotificationRepository notificationRepository;
  late MockCrashlyticsService crashlytics;
  late SubscribeToPushNotificationsUsecase usecase;

  setUp(() {
    notificationRepository = MockNotificationRepository();
    crashlytics = MockCrashlyticsService();
    usecase = SubscribeToPushNotificationsUsecase(
      notificationRepository: notificationRepository,
      crash: crashlytics,
    );
  });

  group('SubscribeToPushNotificationsUsecase', () {
    group('call()', () {
      test('happy flow', () async {
        when(notificationRepository.subscribeToPushNotifications()).thenAnswer(
          (_) async => const Ok(true),
        );

        final result = await usecase.call();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('error returned by repo', () async {
        when(notificationRepository.subscribeToPushNotifications()).thenAnswer(
          (_) async => Err(UnableToSubscribeToPushNotifications()),
        );

        final result = await usecase.call();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToSubscribeToPushNotifications>());
      });

      test('repo throws error', () async {
        when(notificationRepository.subscribeToPushNotifications()).thenThrow(
          Exception('test'),
        );

        final result = await usecase.call();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToSubscribeToPushNotifications>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: SubscribeToPushNotificationsUsecase.crashlyticsLabelCall,
          ),
        ).called(1);
      });
    });
  });
}
