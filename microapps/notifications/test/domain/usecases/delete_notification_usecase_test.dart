import 'package:crashlytics/crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:notifications/domain/usecases/delete_notification_usecase.dart';
import 'package:result/result.dart';

import 'delete_notification_usecase_test.mocks.dart';

@GenerateMocks([
  NotificationRepository,
  CrashlyticsService,
])
void main() {
  late MockNotificationRepository notificationRepository;
  late MockCrashlyticsService crashlytics;
  late DeleteNotificationUsecase usecase;

  setUp(() {
    notificationRepository = MockNotificationRepository();
    crashlytics = MockCrashlyticsService();
    usecase = DeleteNotificationUsecase(
      notificationRepository: notificationRepository,
      crash: crashlytics,
    );
  });

  group('DeleteNotificationsUsecase', () {
    group('call()', () {
      const notifId = 123;

      test('happy flow', () async {
        when(notificationRepository.deleteNotification(notifId)).thenAnswer(
          (_) async => const Ok(true),
        );

        final result = await usecase.call(notifId);

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('error returned by repo', () async {
        when(notificationRepository.deleteNotification(notifId)).thenAnswer(
          (_) async => Err(UnableToDeleteNotification()),
        );

        final result = await usecase.call(notifId);

        expect(result.isErr, true);
        expect(result.err, isA<UnableToDeleteNotification>());
      });

      test('repo throws error', () async {
        when(notificationRepository.deleteNotification(notifId)).thenThrow(
          Exception('test'),
        );

        final result = await usecase.call(notifId);

        expect(result.isErr, true);
        expect(result.err, isA<UnableToDeleteNotification>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: DeleteNotificationUsecase.crashlyticsLabelCall,
          ),
        ).called(1);
      });
    });
  });
}
