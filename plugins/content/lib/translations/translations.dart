import 'dart:async';

import 'package:content/translations/errors/fetch_translations_strategy_errors.dart';
import 'package:content/translations/strategies/fetch_translations_strategy.dart';
import 'package:content/translations/strategies/missing_key_handler_strategy.dart';
import 'package:crashlytics/crashlytics.dart';
import 'package:local_storage/local_storage.dart';

class Translations {
  Translations({
    required this.crashlytics,
    required this.fetchStrategy,
    required this.missingKeyHandlerStrategy,
  });

  final CrashlyticsService crashlytics;
  final FetchTranslationsStrategy fetchStrategy;
  final MissingKeyHandlerStrategy missingKeyHandlerStrategy;

  late Json? _translations;
  bool _loaded = false;

  void loadTranslations(Json json) {
    _loaded = true;
    _translations = json;
  }

  Future<void> load() async {
    try {
      final translationsResult = await fetchStrategy();

      translationsResult.check
        ..ifOk<Json>(loadTranslations)
        ..ifErr<FetchTranslationsStrategyError>((err) => throw err);
    } catch (e, s) {
      unawaited(
        crashlytics.logError(e, s, reason: 'Translations.load'),
      );
    }
  }

  String call(
    String key, {
    Map<String, String>? args,
  }) {
    try {
      if (!_loaded) {
        throw Exception(
          'JsonBasedTranslations.call called before translations were loaded',
        );
      }
      final value = _translations!.readString(key);
      if (value == null) {
        throw Exception('Translation not found: $key');
      }
      return _format(
        key: key,
        value: value,
        args: args,
      );
    } catch (e, s) {
      unawaited(
        crashlytics.logError(e, s, reason: 'Translations.call'),
      );
      return missingKeyHandlerStrategy(key);
    }
  }

  String _format({
    required String key,
    required String value,
    Map<String, String>? args,
  }) {
    if (args == null) {
      return value;
    }

    var res = value;

    for (final arg in args.entries) {
      if (!res.contains('{{${arg.key}}}')) {
        crashlytics.logError(
          Exception(
            'Translation for $key contains unused argument: "$value" -> "$res"',
          ),
          StackTrace.current,
          reason: 'Translations._format',
        );
      }

      res = res.replaceAll('{{${arg.key}}}', arg.value);
    }

    if (res.contains(RegExp(r'\{\{(\w+)\}\}'))) {
      crashlytics.logError(
        Exception(
          'Translation for $key contains missing arguments: "$value" -> "$res"',
        ),
        StackTrace.current,
        reason: 'Translations._format',
      );
    }

    return res;
  }
}
