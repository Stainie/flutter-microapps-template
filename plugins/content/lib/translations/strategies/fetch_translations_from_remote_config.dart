import 'dart:async';

import 'package:content/translations/errors/fetch_translations_strategy_errors.dart';
import 'package:content/translations/strategies/fetch_translations_strategy.dart';
import 'package:crashlytics/crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:local_storage/local_storage.dart';
import 'package:result/result.dart';

class FetchTranslationsFromRemoteConfig extends FetchTranslationsStrategy {
  FetchTranslationsFromRemoteConfig({
    required this.crashlytics,
    required this.remoteConfig,
    required this.localStorage,
    required super.locale,
  });

  final CrashlyticsService crashlytics;
  final FirebaseRemoteConfig remoteConfig;
  final LocalStorage localStorage;

  @override
  Future<Result<FetchTranslationsStrategyError, Json>> call() async {
    try {
      final translations = remoteConfig.getString('translations');
      return Ok(Json.decode(translations));
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: 'FetchTranslationsFromRemoteConfig.call',
        ),
      );
      return Err(UnableToFetchTranslations(locale.toString()));
    }
  }
}
