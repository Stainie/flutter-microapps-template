abstract class FetchTranslationsStrategyError implements Exception {
  String get message;
}

class UnableToFetchTranslations implements FetchTranslationsStrategyError {
  UnableToFetchTranslations(this.locale);
  final String locale;

  @override
  String get message => 'Unable to fetch translations for locale=$locale';
}
