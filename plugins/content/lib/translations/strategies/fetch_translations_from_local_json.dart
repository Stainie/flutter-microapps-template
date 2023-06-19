import 'dart:async';

import 'package:content/translations/errors/fetch_translations_strategy_errors.dart';
import 'package:content/translations/strategies/fetch_translations_strategy.dart';
import 'package:crashlytics/crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:local_storage/local_storage.dart';
import 'package:result/result.dart';

class FetchTranslationsFromLocalJson extends FetchTranslationsStrategy {
  FetchTranslationsFromLocalJson({
    required this.crashlytics,
    required super.locale,
  });

  final CrashlyticsService crashlytics;

  @override
  Future<Result<FetchTranslationsStrategyError, Json>> call() async {
    try {
      final json = Json.decode(
        await rootBundle
            .loadString('packages/assets/assets/translations/local_en.json'),
      );

      return Ok(json);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: 'FetchTranslationsFromLocalJson.call',
        ),
      );
      return Err(UnableToFetchTranslations(locale.toString()));
    }
  }
}
