// Mocks generated by Mockito 5.3.2 from annotations
// in notifications/test/domain/usecases/get_notifications_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:crashlytics/crashlytics_service.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:notifications/domain/entities/notification.dart' as _i6;
import 'package:notifications/domain/errors/notification_errors.dart' as _i5;
import 'package:notifications/domain/repositories/notification_repository.dart'
    as _i3;
import 'package:result/result.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResult_0<ERR extends Object, OK extends Object> extends _i1.SmartFake
    implements _i2.Result<ERR, OK> {
  _FakeResult_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NotificationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationRepository extends _i1.Mock
    implements _i3.NotificationRepository {
  MockNotificationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.NotificationError, bool>>
      subscribeToPushNotifications() => (super.noSuchMethod(
            Invocation.method(
              #subscribeToPushNotifications,
              [],
            ),
            returnValue:
                _i4.Future<_i2.Result<_i5.NotificationError, bool>>.value(
                    _FakeResult_0<_i5.NotificationError, bool>(
              this,
              Invocation.method(
                #subscribeToPushNotifications,
                [],
              ),
            )),
          ) as _i4.Future<_i2.Result<_i5.NotificationError, bool>>);
  @override
  _i4.Future<_i2.Result<_i5.NotificationError, bool>>
      pushNotificationsPermissionDenied() => (super.noSuchMethod(
            Invocation.method(
              #pushNotificationsPermissionDenied,
              [],
            ),
            returnValue:
                _i4.Future<_i2.Result<_i5.NotificationError, bool>>.value(
                    _FakeResult_0<_i5.NotificationError, bool>(
              this,
              Invocation.method(
                #pushNotificationsPermissionDenied,
                [],
              ),
            )),
          ) as _i4.Future<_i2.Result<_i5.NotificationError, bool>>);
  @override
  _i4.Future<_i2.Result<_i5.NotificationError, bool>> changeDeviceLanguage() =>
      (super.noSuchMethod(
        Invocation.method(
          #changeDeviceLanguage,
          [],
        ),
        returnValue: _i4.Future<_i2.Result<_i5.NotificationError, bool>>.value(
            _FakeResult_0<_i5.NotificationError, bool>(
          this,
          Invocation.method(
            #changeDeviceLanguage,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Result<_i5.NotificationError, bool>>);
  @override
  _i4.Future<_i2.Result<_i5.NotificationError, bool>>
      unsubscribeFromPushNotifications() => (super.noSuchMethod(
            Invocation.method(
              #unsubscribeFromPushNotifications,
              [],
            ),
            returnValue:
                _i4.Future<_i2.Result<_i5.NotificationError, bool>>.value(
                    _FakeResult_0<_i5.NotificationError, bool>(
              this,
              Invocation.method(
                #unsubscribeFromPushNotifications,
                [],
              ),
            )),
          ) as _i4.Future<_i2.Result<_i5.NotificationError, bool>>);
  @override
  _i4.Future<_i2.Result<_i5.NotificationError, List<_i6.Notification>>>
      getNotifications() => (super.noSuchMethod(
            Invocation.method(
              #getNotifications,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.Result<_i5.NotificationError,
                        List<_i6.Notification>>>.value(
                _FakeResult_0<_i5.NotificationError, List<_i6.Notification>>(
              this,
              Invocation.method(
                #getNotifications,
                [],
              ),
            )),
          ) as _i4.Future<
              _i2.Result<_i5.NotificationError, List<_i6.Notification>>>);
  @override
  _i4.Future<_i2.Result<_i5.NotificationError, bool>> readNotification(
          int? notificationId) =>
      (super.noSuchMethod(
        Invocation.method(
          #readNotification,
          [notificationId],
        ),
        returnValue: _i4.Future<_i2.Result<_i5.NotificationError, bool>>.value(
            _FakeResult_0<_i5.NotificationError, bool>(
          this,
          Invocation.method(
            #readNotification,
            [notificationId],
          ),
        )),
      ) as _i4.Future<_i2.Result<_i5.NotificationError, bool>>);
  @override
  _i4.Future<_i2.Result<_i5.NotificationError, bool>> deleteNotification(
          int? notificationId) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteNotification,
          [notificationId],
        ),
        returnValue: _i4.Future<_i2.Result<_i5.NotificationError, bool>>.value(
            _FakeResult_0<_i5.NotificationError, bool>(
          this,
          Invocation.method(
            #deleteNotification,
            [notificationId],
          ),
        )),
      ) as _i4.Future<_i2.Result<_i5.NotificationError, bool>>);
}

/// A class which mocks [CrashlyticsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCrashlyticsService extends _i1.Mock
    implements _i7.CrashlyticsService {
  MockCrashlyticsService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> logError(
    Object? exception,
    StackTrace? stack, {
    String? reason,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #logError,
          [
            exception,
            stack,
          ],
          {#reason: reason},
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> logNetworkError({
    required String? url,
    required Map<String, Object?>? bodyRequest,
    required Map<String, Object?>? bodyResponse,
    required int? statusCode,
    required String? method,
    required Map<String, Object?>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #logNetworkError,
          [],
          {
            #url: url,
            #bodyRequest: bodyRequest,
            #bodyResponse: bodyResponse,
            #statusCode: statusCode,
            #method: method,
            #headers: headers,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> setUserId(String? userId) => (super.noSuchMethod(
        Invocation.method(
          #setUserId,
          [userId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> setCustomKey(
    String? key,
    Object? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setCustomKey,
          [
            key,
            value,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> setCurrentScreen(String? currentPage) => (super.noSuchMethod(
        Invocation.method(
          #setCurrentScreen,
          [currentPage],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> onFlutterError(_i8.FlutterErrorDetails? details) =>
      (super.noSuchMethod(
        Invocation.method(
          #onFlutterError,
          [details],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
