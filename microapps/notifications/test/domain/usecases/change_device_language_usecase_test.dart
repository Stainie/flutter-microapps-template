import 'package:crashlytics/crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:notifications/domain/repositories/notification_repository.dart';
import 'package:notifications/domain/usecases/change_device_language_usecase.dart';
import 'package:result/result.dart';

import 'change_device_language_usecase_test.mocks.dart';

@GenerateMocks([
  NotificationRepository,
  CrashlyticsService,
])
void main() {
  late MockNotificationRepository notificationRepository;
  late MockCrashlyticsService crashlytics;
  late ChangeDeviceLanguageUsecase usecase;

  setUp(() {
    notificationRepository = MockNotificationRepository();
    crashlytics = MockCrashlyticsService();
    usecase = ChangeDeviceLanguageUsecase(
      notificationRepository: notificationRepository,
      crash: crashlytics,
    );
  });

  group('ChangeDeviceLanguageUsecase', () {
    group('call()', () {
      test('happy flow', () async {
        when(notificationRepository.changeDeviceLanguage()).thenAnswer(
          (_) async => const Ok(true),
        );

        final result = await usecase.call();

        expect(result.isOk, true);
        expect(result.ok, true);
      });

      test('error returned by repo', () async {
        when(notificationRepository.changeDeviceLanguage()).thenAnswer(
          (_) async => Err(UnableToChangeDeviceLanguage()),
        );

        final result = await usecase.call();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToChangeDeviceLanguage>());
      });

      test('repo throws error', () async {
        when(notificationRepository.changeDeviceLanguage()).thenThrow(
          Exception('test'),
        );

        final result = await usecase.call();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToChangeDeviceLanguage>());

        verify(
          crashlytics.logError(
            any,
            any,
            reason: ChangeDeviceLanguageUsecase.crashlyticsLabelCall,
          ),
        ).called(1);
      });
    });
  });
}
