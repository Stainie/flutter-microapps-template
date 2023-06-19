import 'dart:async';
import 'dart:convert';

import 'package:crashlytics/crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:local_storage/json.dart';
import 'package:local_storage/serializable.dart';
import 'package:result/result.dart';
import 'package:content/features_flag/features_flag_errors.dart';
import 'package:content/features_flag/features_flag_service.dart';

class FeaturesFlagRemoteConfigServiceImpl implements FeaturesFlagService {
  FeaturesFlagRemoteConfigServiceImpl({
    required this.remoteConfig,
    required this.crashlytics,
  });

  final CrashlyticsService crashlytics;
  final FirebaseRemoteConfig remoteConfig;

  @override
  Future<Result<FeaturesFlagError, T>>
      getFeatureFlag<T extends BiSerializable>({
    required String key,
    required T Function(Json json) fromJson,
  }) async {
    try {
      final featureFlagValue = remoteConfig.getString('featuresflag');
      final json = Json(jsonDecode(featureFlagValue));
      final obj = json.readCustomObject(key, fromJson);

      if (obj == null) {
        return Err(UnableToFetchFlag());
      }

      return Ok(obj);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: 'FeaturesFlagRemoteConfigServiceImpl.getFeatureFlag',
        ),
      );
    }
    return Err(UnableToFetchFlag());
  }
}
