import 'package:content/translations/strategies/missing_key_handler_strategy.dart';

class MissingKeyHandlerShowEmptyString extends MissingKeyHandlerStrategy {
  @override
  String call(String key) => '';
}
