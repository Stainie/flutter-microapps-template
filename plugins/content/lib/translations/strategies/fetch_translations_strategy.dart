import 'package:content/translations/errors/fetch_translations_strategy_errors.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';
import 'package:result/result.dart';

export 'fetch_translations_from_litebit_cdn.dart';
export 'fetch_translations_from_local_json.dart';
export 'fetch_translations_from_remote_config.dart';

abstract class FetchTranslationsStrategy {
  FetchTranslationsStrategy({
    required this.locale,
  });

  final Locale locale;

  Future<Result<FetchTranslationsStrategyError, Json>> call();
}
