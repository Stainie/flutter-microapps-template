import 'package:crashlytics/crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_abstraction/http_abstraction.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notifications/datasource/services/notification_service_impl.dart';
import 'package:notifications/domain/entities/notification_user.dart';
import 'package:notifications/domain/errors/notification_errors.dart';
import 'package:result/result.dart';

import 'notification_service_impl_test.mocks.dart';

@GenerateMocks([
  IHttpClient,
  CrashlyticsService,
])
void main() {
  late MockIHttpClient httpClient;
  late MockCrashlyticsService crashlytics;
  late NotificationServiceImpl service;
  const fcmToken = 'token';
  const firstName = 'firstName';
  const lastName = 'lastName';

  setUp(() {
    httpClient = MockIHttpClient();
    crashlytics = MockCrashlyticsService();
    service = NotificationServiceImpl(
      client: httpClient,
      crashlytics: crashlytics,
      fcmToken: fcmToken,
    );
  });

  group('NotificationServiceImpl', () {
    group('addNewDevice()', () {
      test('happy flow', () async {
        when(
          httpClient.post(
            endpoint: 'v1/device',
            body: HttpBodyJson(
              {
                'token': fcmToken,
                'userFirstName': firstName,
                'userLastName': lastName,
              },
            ),
          ),
        ).thenAnswer((_) async => Ok(HttpResponse.empty()));

        final result = await service.addNewDevice(
          NotificationUser(
            firstName: firstName,
            lastName: lastName,
          ),
        );

        expect(result.isOk, true);
        expect(result.ok, equals(true));
      });

      test('error response', () async {
        when(
          httpClient.post(
            endpoint: 'v1/device',
            body: HttpBodyJson(
              {
                'token': fcmToken,
                'userFirstName': firstName,
                'userLastName': lastName,
              },
            ),
          ),
        ).thenAnswer((_) async => Err(UnauthorizedError.empty()));

        final result = await service.addNewDevice(
          NotificationUser(
            firstName: firstName,
            lastName: lastName,
          ),
        );

        expect(result.isErr, true);
        expect(result.err, isA<UnableToSubscribeToPushNotifications>());
      });

      test('throws', () {
        when(
          httpClient.post(
            endpoint: 'v1/device',
            body: HttpBodyJson(
              {
                'token': fcmToken,
                'userFirstName': firstName,
                'userLastName': lastName,
              },
            ),
          ),
        ).thenThrow(Exception());

        try {
          service.addNewDevice(
            NotificationUser(
              firstName: firstName,
              lastName: lastName,
            ),
          );
        } catch (e) {
          expect(e, isA<Exception>());
        }

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationServiceImpl.crashlyticsLabelAddNewDevice,
          ),
        ).called(1);
      });
    });

    group('addNewUser()', () {
      test('happy flow', () async {
        when(
          httpClient.post(
            endpoint: 'v1/user',
            body: HttpBodyJson(
              {
                'firstName': firstName,
                'lastName': lastName,
              },
            ),
          ),
        ).thenAnswer((_) async => Ok(HttpResponse.empty()));

        final result = await service.addNewUser(
          NotificationUser(
            firstName: firstName,
            lastName: lastName,
          ),
        );

        expect(result.isOk, true);
        expect(result.ok, equals(true));
      });

      test('error response', () async {
        when(
          httpClient.post(
              endpoint: 'v1/user',
              body: HttpBodyJson(
                {
                  'firstName': firstName,
                  'lastName': lastName,
                },
              )),
        ).thenAnswer((_) async => Err(UnauthorizedError.empty()));

        final result = await service.addNewUser(
          NotificationUser(
            firstName: firstName,
            lastName: lastName,
          ),
        );

        expect(result.isErr, true);
        expect(result.err, isA<UnableToSubscribeToPushNotifications>());
      });

      test('throws', () {
        when(
          httpClient.post(
            endpoint: 'v1/user',
            body: HttpBodyJson(
              {
                'firstName': firstName,
                'lastName': lastName,
              },
            ),
          ),
        ).thenThrow(Exception());

        try {
          service.addNewUser(
            NotificationUser(
              firstName: firstName,
              lastName: lastName,
            ),
          );
        } catch (e) {
          expect(e, isA<Exception>());
        }

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationServiceImpl.crashlyticsLabelAddNewUser,
          ),
        ).called(1);
      });
    });

    group('deleteNotification', () {
      const notificationId = 123;

      test('happy flow', () async {
        when(
          httpClient.delete(
            endpoint: 'v1/notification?notificationId=$notificationId',
          ),
        ).thenAnswer((_) async => Ok(HttpResponse.empty()));

        final result = await service.deleteNotification(notificationId);

        expect(result.isOk, true);
        expect(result.ok, equals(true));
      });

      test('error response', () async {
        when(
          httpClient.delete(
            endpoint: 'v1/notification?notificationId=$notificationId',
          ),
        ).thenAnswer((_) async => Err(UnauthorizedError.empty()));

        final result = await service.deleteNotification(notificationId);

        expect(result.isErr, true);
        expect(result.err, isA<UnableToDeleteNotification>());
      });

      test('throws', () {
        when(
          httpClient.delete(
            endpoint: 'v1/notification?notificationId=$notificationId',
          ),
        ).thenThrow(Exception());

        try {
          service.deleteNotification(notificationId);
        } catch (e) {
          expect(e, isA<Exception>());
        }

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationServiceImpl.crashlyticsLabelDeleteNotification,
          ),
        ).called(1);
      });
    });

    group('editDevice()', () {
      test('happy flow', () async {
        when(
          httpClient.put(
            endpoint: 'v1/device',
            body: HttpBodyJson(
              {
                'token': fcmToken,
                'userFirstName': firstName,
                'userLastName': lastName,
              },
            ),
          ),
        ).thenAnswer((_) async => Ok(HttpResponse.empty()));

        final result = await service.editDevice(
          NotificationUser(
            firstName: firstName,
            lastName: lastName,
          ),
        );

        expect(result.isOk, true);
        expect(result.ok, equals(true));
      });

      test('error response', () async {
        when(
          httpClient.put(
            endpoint: 'v1/device',
            body: HttpBodyJson(
              {
                'token': fcmToken,
                'userFirstName': firstName,
                'userLastName': lastName,
              },
            ),
          ),
        ).thenAnswer((_) async => Err(UnauthorizedError.empty()));

        final result = await service.editDevice(
          NotificationUser(
            firstName: firstName,
            lastName: lastName,
          ),
        );

        expect(result.isErr, true);
        expect(result.err, isA<UnableToChangeDeviceLanguage>());
      });

      test('throws', () {
        when(
          httpClient.put(
            endpoint: 'v1/device',
            body: HttpBodyJson(
              {
                'token': fcmToken,
                'userFirstName': firstName,
                'userLastName': lastName,
              },
            ),
          ),
        ).thenThrow(Exception());

        try {
          service.editDevice(
            NotificationUser(
              firstName: firstName,
              lastName: lastName,
            ),
          );
        } catch (e) {
          expect(e, isA<Exception>());
        }

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationServiceImpl.crashlyticsLabelEditDevice,
          ),
        ).called(1);
      });
    });

    group('getNotifications()', () {
      // TODO(marko): Add tests when implemented.
    });

    group('removeDevice', () {
      test('happy flow', () async {
        when(
          httpClient.delete(
            endpoint: 'v1/device',
            body: HttpBodyJson(
              {
                'token': fcmToken,
              },
            ),
          ),
        ).thenAnswer((_) async => Ok(HttpResponse.empty()));

        final result = await service.removeDevice();

        expect(result.isOk, true);
        expect(result.ok, equals(true));
      });

      test('error response', () async {
        when(
          httpClient.delete(
            endpoint: 'v1/device',
            body: HttpBodyJson(
              {
                'token': fcmToken,
              },
            ),
          ),
        ).thenAnswer((_) async => Err(UnauthorizedError.empty()));

        final result = await service.removeDevice();

        expect(result.isErr, true);
        expect(result.err, isA<UnableToUnsubscribeFromPushNotifications>());
      });

      test('throws', () {
        when(
          httpClient.delete(
            endpoint: 'v1/device',
            body: HttpBodyJson(
              {
                'token': fcmToken,
              },
            ),
          ),
        ).thenThrow(Exception());

        try {
          service.removeDevice();
        } catch (e) {
          expect(e, isA<Exception>());
        }

        verify(
          crashlytics.logError(
            any,
            any,
            reason: NotificationServiceImpl.crashlyticsLabelRemoveDevice,
          ),
        ).called(1);
      });

      group('updateNotificationStatus()', () {
        const notificationId = 123;

        test('happy flow', () async {
          when(
            httpClient.patch(
              endpoint: 'v1/notification?notificationId=$notificationId',
            ),
          ).thenAnswer((_) async => Ok(HttpResponse.empty()));

          final result = await service.updateNotificationStatus(notificationId);

          expect(result.isOk, true);
          expect(result.ok, equals(true));
        });

        test('error response', () async {
          when(
            httpClient.patch(
              endpoint: 'v1/notification?notificationId=$notificationId',
            ),
          ).thenAnswer((_) async => Err(UnauthorizedError.empty()));

          final result = await service.updateNotificationStatus(notificationId);

          expect(result.isErr, true);
          expect(result.err, isA<UnableToMarkNotificationAsRead>());
        });

        test('throws', () {
          when(
            httpClient.patch(
              endpoint: 'v1/notification?notificationId=$notificationId',
            ),
          ).thenThrow(Exception());

          try {
            service.updateNotificationStatus(notificationId);
          } catch (e) {
            expect(e, isA<Exception>());
          }

          verify(
            crashlytics.logError(
              any,
              any,
              reason: NotificationServiceImpl
                  .crashlyticsLabelUpdateNotificationStatus,
            ),
          ).called(1);
        });
      });
    });
  });
}
