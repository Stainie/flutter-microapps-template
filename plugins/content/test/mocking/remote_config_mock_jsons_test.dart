import 'package:content/mocking/remote_config_mock_jsons.dart';
import 'package:crashlytics/crashlytics_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/local_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_config_mock_jsons_test.mocks.dart';

@GenerateMocks([
  FirebaseRemoteConfig,
  CrashlyticsService,
  LocalStorage,
])
void main() {
  late MockFirebaseRemoteConfig remoteConfig;
  late MockCrashlyticsService crashlytics;
  late MockLocalStorage localStorage;
  late RemoteConfigMockJsons remoteConfigMockJsons;

  setUp(() {
    remoteConfig = MockFirebaseRemoteConfig();
    crashlytics = MockCrashlyticsService();
    localStorage = MockLocalStorage();
    remoteConfigMockJsons = RemoteConfigMockJsons(
      remoteConfig: remoteConfig,
      crashlytics: crashlytics,
      localStorage: localStorage,
    );
  });

  group('load', () {
    group('On Error', () {
      test('should log error', () async {
        when(remoteConfig.getString('mock_jsons')).thenThrow(Exception());

        await remoteConfigMockJsons.load();

        verify(
          crashlytics.logError(
            any,
            any,
            reason: 'RemoteConfigMockJsons.load',
          ),
        ).called(1);
      }); // should log error
    });
    group('On Success', () {
      test('should set mockJsons', () async {
        when(remoteConfig.getString('mock_jsons'))
            .thenReturn('{"key": "value"}');

        await remoteConfigMockJsons.load();

        expect(
          remoteConfigMockJsons.json!.readString('key'),
          'value',
        );
      }); // should set mockJsons
    });
  });

  group('call', () {
    group('On Error', () {
      test('should log error', () async {
        when(remoteConfig.getString('mock_jsons')).thenThrow(Exception());

        await remoteConfigMockJsons.load();
        remoteConfigMockJsons('key');

        verify(
          crashlytics.logError(
            any,
            any,
            reason: anyNamed('reason'),
          ),
        ).called(1);
      }); // should log error
    });

    group('On Success', () {
      test('should return value', () async {
        when(remoteConfig.getString('mock_jsons'))
            .thenReturn('{"key": "value"}');

        await remoteConfigMockJsons.load();

        expect(
          remoteConfigMockJsons('key'),
          'value',
        );
      }); // should return value
    });
  });
}
