library local_storage;

export 'json.dart';
export 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_storage/json.dart';
import 'package:local_storage/serializable.dart';

abstract class LocalStorage {
  Future<void> deleteAllKeys();

  Future<void> deleteKey({required String key});

  Future<T?> get<T extends BiSerializable>({
    required String key,
    required T Function(Json json) fromJson,
  });

  Future<bool> set<T extends BiSerializable>({
    required String key,
    required T value,
    Duration? expiration,
  });

  Future<bool> setCached<T extends BiSerializable>({
    required String key,
    required T value,
    Duration? expiration,
  });
}
