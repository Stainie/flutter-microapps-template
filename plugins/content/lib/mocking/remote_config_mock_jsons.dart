import 'dart:async';
import 'dart:convert';

import 'package:content/mock_jsons.dart';
import 'package:crashlytics/crashlytics_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:local_storage/local_storage.dart';

class RemoteConfigMockJsons extends MockJsons {
  RemoteConfigMockJsons({
    required this.remoteConfig,
    required this.crashlytics,
    required this.localStorage,
  });

  FirebaseRemoteConfig remoteConfig;
  CrashlyticsService crashlytics;
  LocalStorage localStorage;

  Json? json;

  Future load() async {
    try {
      final mockJsons = remoteConfig.getString('mock_jsons');
      json = Json(jsonDecode(mockJsons));
    } catch (e, s) {
      unawaited(
        crashlytics.logError(e, s, reason: 'RemoteConfigMockJsons.load'),
      );
    }
  }

  @override
  String call(String key) {
    try {
      final value = json!.readString(key);
      if (value == null) {
        throw Exception('Json not found: $key');
      }
      return value;
    } catch (e, s) {
      unawaited(
        crashlytics.logError(e, s, reason: 'RemoteConfigMockJsons.call'),
      );
      return '';
    }
  }
}
