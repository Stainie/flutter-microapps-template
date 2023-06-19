import 'package:crashlytics/crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:result/result.dart';

import 'get_notifications_usecase_test.mocks.dart';

@GenerateMocks([
  NotificationRepository,
  CrashlyticsService,
])
void main() {
  late MockNotificationRepository notificationRepository;
  late MockCrashlyticsService crashlytics;
  late GetNotificationsUseCase usecase;

  setUp(() {
    notificationRepository = MockNotificationRepository();
    crashlytics = MockCrashlyticsService();
    usecase = GetNotificationsUseCase(
      notificationRepository: notificationRepository,
      crash: crashlytics,
    );
  });

  group('GetNotificationsUsecase', () {
    group('call()', () {
      test('happy flow', () async {
        when(notificationRepository.getNotifications()).thenAnswer(
          (_) async => const Ok([]),
        );

        final result = await usecase.call();

        expect(result.isOk, true);
        expect(result.ok.isEmpty, true);
      });

      test('error returned by repo', () async {
        when(notificationRepository.getNotifications()).thenAnswer(
          (_) async => Err(UnableToGetNotifications()),
        );

        final result = await usecase.call();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToGetNotifications>());
      });

      test('repo throws error', () async {
        when(notificationRepository.getNotifications()).thenThrow(
          Exception('test'),
        );

        final result = await usecase.call();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToGetNotifications>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: GetNotificationsUseCase.crashlyticsLabelCall,
          ),
        ).called(1);
      });
    });
  });
}
