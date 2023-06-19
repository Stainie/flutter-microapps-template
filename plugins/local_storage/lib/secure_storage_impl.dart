import 'dart:async';
import 'dart:convert';

import 'package:crashlytics/crashlytics_service.dart';
import 'package:local_storage/container_storage.dart';
import 'package:local_storage/local_storage.dart';
import 'package:local_storage/serializable.dart';

class SecureStorageImpl implements LocalStorage {
  SecureStorageImpl({
    required this.storage,
    required this.crashlytics,
  });

  final FlutterSecureStorage storage;
  final CrashlyticsService crashlytics;
  final Map<String, ContainerStorage<dynamic>> _cache = {};

  @override
  Future deleteAllKeys() async {
    await storage.deleteAll();
  }

  @override
  Future deleteKey({required String key}) async {
    await storage.delete(key: key);
  }

  @override
  Future<T?> get<T extends BiSerializable>({
    required String key,
    required T Function(Json json) fromJson,
  }) async {
    try {
      if (_cache.containsKey(key)) {
        final container = _cache[key];
        if (container != null && !container.isExpired()) {
          return container.data;
        }
      }

      final value = await storage.read(key: key);
      if (value != null) {
        final container = ContainerStorage<T>.fromJson(
          json: Json.decode(value),
          fromJson: fromJson,
        );

        if (container.isExpired()) {
          await storage.delete(key: key);
          return null;
        }

        return container.data;
      }
    } catch (e, s) {
      unawaited(
        crashlytics.logError(e, s, reason: 'SecureStorageImpl get failed'),
      );
    }
    return null;
  }

  @override
  Future<bool> set<T extends BiSerializable>({
    required String key,
    required T value,
    Duration? expiration,
  }) async {
    try {
      final updatedExpiration = expiration != null
          ? Duration(
              milliseconds: DateTime.now().millisecondsSinceEpoch +
                  expiration.inMilliseconds,
            )
          : null;

      final container =
          ContainerStorage<T>(data: value, expiration: updatedExpiration);
      await storage.write(key: key, value: jsonEncode(container.toJson()));
      return true;
    } catch (e, s) {
      unawaited(
        crashlytics.logError(e, s, reason: 'SecureStorageImpl set failed'),
      );
      return false;
    }
  }

  @override
  Future<bool> setCached<T extends BiSerializable>({
    required String key,
    required T value,
    Duration? expiration,
  }) async {
    try {
      final validSet =
          await set(key: key, value: value, expiration: expiration);
      if (!validSet) {
        return false;
      }
      _cache[key] = ContainerStorage(data: value, expiration: expiration);
      return true;
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: 'SecureStorageImpl setCached failed',
        ),
      );
      return false;
    }
  }
}
