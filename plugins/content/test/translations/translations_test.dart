import 'package:content/translations/errors/fetch_translations_strategy_errors.dart';
import 'package:content/translations/strategies/fetch_translations_strategy.dart';
import 'package:content/translations/strategies/missing_key_handler_strategy.dart';
import 'package:content/translations/translations.dart';
import 'package:crashlytics/crashlytics_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/local_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:result/result.dart';

import 'translations_test.mocks.dart';

@GenerateMocks([
  CrashlyticsService,
  FetchTranslationsStrategy,
  MissingKeyHandlerStrategy,
])
void main() {
  late MockCrashlyticsService crashlytics;
  late MockFetchTranslationsStrategy fetchStrategy;
  late MockMissingKeyHandlerStrategy missingKeyHandlerStrategy;
  late Translations translations;

  setUp(() {
    crashlytics = MockCrashlyticsService();
    fetchStrategy = MockFetchTranslationsStrategy();
    missingKeyHandlerStrategy = MockMissingKeyHandlerStrategy();

    translations = Translations(
      crashlytics: crashlytics,
      fetchStrategy: fetchStrategy,
      missingKeyHandlerStrategy: missingKeyHandlerStrategy,
    );
  });

  group('Translations', () {
    test('Logs exception when not loaded and returns empty string', () {
      when(missingKeyHandlerStrategy(any)).thenReturn('');

      expect(
        translations('key'),
        '',
      );

      verify(
        missingKeyHandlerStrategy('key'),
      ).called(1);

      verify(
        crashlytics.logError(
          any,
          any,
          reason: 'Translations.call',
        ),
      ).called(1);
    });

    test('Returns value when loaded', () async {
      when(fetchStrategy.call()).thenAnswer(
        (_) => Future.value(
          Ok(
            Json(
              {
                'key': 'value',
              },
            ),
          ),
        ),
      );
      await translations.load();

      expect(
        translations('key'),
        'value',
      );

      verifyNever(
        missingKeyHandlerStrategy('key'),
      );

      verifyNever(
        crashlytics.logError(
          any,
          any,
          reason: anyNamed('reason'),
        ),
      );
    });

    test('Calls missing key handler and logs error when key is not found',
        () async {
      when(missingKeyHandlerStrategy(any)).thenReturn('');

      when(fetchStrategy.call()).thenAnswer(
        (_) => Future.value(
          Ok(
            Json(
              {
                'key': 'value',
              },
            ),
          ),
        ),
      );
      await translations.load();

      expect(
        translations('key2'),
        '',
      );

      verify(
        missingKeyHandlerStrategy('key2'),
      ).called(1);

      verify(
        crashlytics.logError(
          any,
          any,
          reason: 'Translations.call',
        ),
      ).called(1);
    });

    test('Calls missing key handler and logs error when key is not found',
        () async {
      when(missingKeyHandlerStrategy(any)).thenReturn('');

      when(fetchStrategy.call()).thenAnswer(
        (_) => Future.value(
          Ok(
            Json(
              {
                'key': 'value',
              },
            ),
          ),
        ),
      );
      await translations.load();

      translations('key2');

      verify(
        missingKeyHandlerStrategy.call('key2'),
      ).called(1);
    });
  });

  test('Logs exception when fail to load', () async {
    when(fetchStrategy.call()).thenAnswer(
      (_) => Future.value(
        Err(
          UnableToFetchTranslations('en'),
        ),
      ),
    );

    await translations.load();

    verify(
      crashlytics.logError(
        any,
        any,
        reason: 'Translations.load',
      ),
    ).called(1);
  });

  test('Formatting works correctly', () async {
    when(fetchStrategy.call()).thenAnswer(
      (_) => Future.value(
        Ok(
          Json(
            {
              'key':
                  'Hello {{name}}, hope you\'re doing well with your {{coinAmount}} {{coinName}}!',
            },
          ),
        ),
      ),
    );
    await translations.load();

    expect(
      translations(
        'key',
        args: {
          'name': 'John',
          'coinAmount': '10',
          'coinName': 'BTC',
        },
      ),
      'Hello John, hope you\'re doing well with your 10 BTC!',
    );

    verifyNever(
      missingKeyHandlerStrategy('key'),
    );

    verifyNever(
      crashlytics.logError(
        any,
        any,
        reason: anyNamed('reason'),
      ),
    );
  });

  test('Formatting logs error when key is unused', () async {
    when(fetchStrategy.call()).thenAnswer(
      (_) => Future.value(
        Ok(
          Json(
            {
              'key':
                  'Hello {{name}}, hope you\'re doing well with your {{coinAmount}} {{coinName}}!',
            },
          ),
        ),
      ),
    );
    await translations.load();

    expect(
      translations(
        'key',
        args: {
          'name': 'John',
          'coinAmount': '10',
        },
      ),
      'Hello John, hope you\'re doing well with your 10 {{coinName}}!',
    );

    verify(
      crashlytics.logError(
        any,
        any,
        reason: 'Translations._format',
      ),
    ).called(1);

    verifyNever(
      missingKeyHandlerStrategy('key'),
    );

    verifyNever(
      crashlytics.logError(
        any,
        any,
        reason: anyNamed('reason'),
      ),
    );
  });

  test('Formatting logs error when key is missing', () async {
    when(fetchStrategy.call()).thenAnswer(
      (_) => Future.value(
        Ok(
          Json(
            {
              'key':
                  'Hello {{name}}, hope you\'re doing well with your {{coinAmount}} {{coinName}}!',
            },
          ),
        ),
      ),
    );
    await translations.load();

    expect(
      translations(
        'key',
        args: {
          'name': 'John',
          'coinAmount': '10',
          'coinName': 'BTC',
          'coinSymbol': 'BTC',
        },
      ),
      'Hello John, hope you\'re doing well with your 10 BTC!',
    );

    verify(
      crashlytics.logError(
        any,
        any,
        reason: 'Translations._format',
      ),
    ).called(1);

    verifyNever(
      missingKeyHandlerStrategy('key'),
    );

    verifyNever(
      crashlytics.logError(
        any,
        any,
        reason: anyNamed('reason'),
      ),
    );
  });
}
