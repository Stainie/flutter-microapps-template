import 'package:crashlytics/crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:notifications/domain/usecases/push_notifications_permission_denied_usecase.dart';
import 'package:result/result.dart';

import 'push_notifications_permission_denied_usecase_test.mocks.dart';

@GenerateMocks([
  NotificationRepository,
  CrashlyticsService,
])
void main() {
  late MockNotificationRepository notificationRepository;
  late MockCrashlyticsService crashlytics;
  late PushNotificationsPermissionDeniedUsecase usecase;

  setUp(() {
    notificationRepository = MockNotificationRepository();
    crashlytics = MockCrashlyticsService();
    usecase = PushNotificationsPermissionDeniedUsecase(
      notificationRepository: notificationRepository,
      crash: crashlytics,
    );
  });

  group('PushNotificationsPermissionDeniedUsecase', () {
    group('call()', () {
      test('happy flow', () async {
        when(notificationRepository.pushNotificationsPermissionDenied())
            .thenAnswer(
          (_) async => const Ok(true),
        );

        final result = await usecase.call();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('error returned by repo', () async {
        when(notificationRepository.getNotifications()).thenAnswer(
          (_) async => Err(FailureDueToDisablingPushNotifications()),
        );

        final result = await usecase.call();

        expect(result.isErr, true);
        expect(result.err, isA<FailureDueToDisablingPushNotifications>());
      });

      test('repo throws error', () async {
        when(notificationRepository.getNotifications()).thenThrow(
          Exception('test'),
        );

        final result = await usecase.call();

        expect(result.isErr, true);
        expect(result.err, isA<FailureDueToDisablingPushNotifications>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason:
                PushNotificationsPermissionDeniedUsecase.crashlyticsLabelCall,
          ),
        ).called(1);
      });
    });
  });
}
