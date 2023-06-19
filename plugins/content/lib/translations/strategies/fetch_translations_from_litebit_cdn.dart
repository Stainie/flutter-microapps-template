import 'dart:async';

import 'package:content/translations/errors/fetch_translations_strategy_errors.dart';
import 'package:content/translations/strategies/fetch_translations_strategy.dart';
import 'package:crashlytics/crashlytics.dart';
import 'package:local_storage/local_storage.dart';
import 'package:result/result.dart';
import 'package:http_abstraction/http_client.dart';

class FetchTranslationsFromLitebitCdn extends FetchTranslationsStrategy {
  FetchTranslationsFromLitebitCdn({
    required this.crashlytics,
    required this.liteBitCdnClient,
    required super.locale,
  });

  final CrashlyticsService crashlytics;
  final IHttpClient liteBitCdnClient;

  @override
  Future<Result<FetchTranslationsStrategyError, Json>> call() async {
    try {
      final translationsResponse = await liteBitCdnClient.get(
        endpoint: 'translations/app/${locale.languageCode}.json',
      );

      if (translationsResponse.isErr) {
        return Err(UnableToFetchTranslations(locale.toString()));
      }

      return Ok(Json(translationsResponse.ok.body));
    } catch (e, s) {
      unawaited(
        crashlytics.logError(
          e,
          s,
          reason: 'FetchTranslationsFromLiteBitCdn.call',
        ),
      );
      return Err(UnableToFetchTranslations(locale.toString()));
    }
  }
}
