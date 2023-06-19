import 'package:crashlytics/crashlytics_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_storage/secure_storage_impl.dart';
import 'package:local_storage/serializable.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'secure_storage_impl_test.mocks.dart';
import 'serializable_entity.dart';

@GenerateMocks([
  FlutterSecureStorage,
  CrashlyticsService,
])
void main() {
  late MockFlutterSecureStorage mockFlutterSecureStorage;
  late MockCrashlyticsService mockCrashlyticsService;
  late SecureStorageImpl secureStorageImpl;

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    mockCrashlyticsService = MockCrashlyticsService();
    secureStorageImpl = SecureStorageImpl(
      storage: mockFlutterSecureStorage,
      crashlytics: mockCrashlyticsService,
    );
  });

  group('SecureStorageTest', () {
    group('deleteAllKeys', () {
      test('should call deleteAll on storage', () async {
        await secureStorageImpl.deleteAllKeys();

        verify(mockFlutterSecureStorage.deleteAll());
      });
    });

    group('deleteKey', () {
      test('should call delete on storage', () async {
        const key = 'key';

        await secureStorageImpl.deleteKey(key: key);

        verify(mockFlutterSecureStorage.delete(key: key));
      });
    });

    group('get', () {
      group('On Success', () {
        test('should call read on storage', () async {
          const key = 'key';

          await secureStorageImpl.get<BiSerializable>(
            key: key,
            fromJson: SerializableEntity.fromJson,
          );

          verify(mockFlutterSecureStorage.read(key: key));
        });

        test('should return null if value is null', () async {
          const key = 'key';
          when(mockFlutterSecureStorage.read(key: key))
              .thenAnswer((_) async => null);

          final result = await secureStorageImpl.get<SerializableEntity>(
            key: key,
            fromJson: SerializableEntity.fromJson,
          );

          expect(result, isNull);
        });

        test('should return null if value is expired', () async {
          const key = 'key';
          final expiration = DateTime.now().millisecondsSinceEpoch;
          when(mockFlutterSecureStorage.read(key: key)).thenAnswer(
            (_) async =>
                '{"data":{"test":"testing"},"expiration": $expiration}',
          );

          final result = await secureStorageImpl.get<SerializableEntity>(
            key: key,
            fromJson: SerializableEntity.fromJson,
          );

          expect(result, isNull);
        });

        test('should return value if value is not expired', () async {
          const key = 'key';
          final expiration = DateTime.now().millisecondsSinceEpoch +
              const Duration(hours: 1).inMilliseconds;
          when(mockFlutterSecureStorage.read(key: key)).thenAnswer(
            (_) async =>
                '{"data":{"test":"testing"},"expiration": $expiration}',
          );

          final result = await secureStorageImpl.get<SerializableEntity>(
            key: key,
            fromJson: SerializableEntity.fromJson,
          );

          expect(result, isNotNull);
        });
      });

      group('On Error', () {
        test(
            'should call logError on crashlytics when storage throws Exception',
            () async {
          const key = 'key';
          when(mockFlutterSecureStorage.read(key: key)).thenThrow(Exception());

          await secureStorageImpl.get<SerializableEntity>(
            key: key,
            fromJson: SerializableEntity.fromJson,
          );

          verify(
            mockCrashlyticsService.logError(
              any,
              any,
              reason: 'SecureStorageImpl get failed',
            ),
          );
        });
      });
    });
  });
}
