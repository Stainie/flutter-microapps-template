import 'dart:convert';

import 'package:content/features_flag/feature_flag_remote_config_service.dart';
import 'package:content/features_flag/features_flag_errors.dart';
import 'package:crashlytics/crashlytics_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/local_storage.dart';
import 'package:local_storage/serializable.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'feature_flag_remote_config_service_test.mocks.dart';

@GenerateMocks([
  CrashlyticsService,
  FirebaseRemoteConfig,
  LocalStorage,
])
void main() {
  late MockCrashlyticsService crashlytics;
  late MockFirebaseRemoteConfig remoteConfig;
  late FeaturesFlagRemoteConfigServiceImpl service;

  setUp(() {
    crashlytics = MockCrashlyticsService();
    remoteConfig = MockFirebaseRemoteConfig();
    service = FeaturesFlagRemoteConfigServiceImpl(
      crashlytics: crashlytics,
      remoteConfig: remoteConfig,
    );
  });

  group('getFeatureFlag', () {
    group('On Error', () {
      test('should return an error', () async {
        when(remoteConfig.fetch()).thenThrow(Exception());
        final result = await service.getFeatureFlag<TestA>(
          key: 'key',
          fromJson: TestA.fromJson,
        );
        expect(result.isErr, true);
        expect(result.err, isA<UnableToFetchFlag>());
      });
    });
    group('On Success', () {
      test('should return a Serializable object', () async {
        final json = {
          'test': TestA(field: 'value').toJson(),
        };
        when(remoteConfig.fetch()).thenAnswer((_) async {});
        when(remoteConfig.getString('featuresflag'))
            .thenReturn(jsonEncode(json));
        final result = await service.getFeatureFlag<TestA>(
          key: 'test',
          fromJson: TestA.fromJson,
        );
        expect(result.isOk, true);
        expect(result.ok, isA<TestA>());
        expect(result.ok.field, 'value');
      });
    });
  });
}

class TestA with BiSerializable<TestA> {
  TestA({required this.field});

  factory TestA.empty() => TestA(field: '');
  factory TestA.fromJson(Json json) => TestA(field: json.readString('field')!);

  final String field;

  @override
  TestA fromJson(Json json) => TestA.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {'field': field};

  TestA copyWith(Map<String, dynamic> mutation) =>
      TestA(field: mutation['field'] ?? '');
}
