import 'package:content/translations/strategies/missing_key_handler_strategy.dart';

class MissingKeyHandlerShowKeyName extends MissingKeyHandlerStrategy {
  @override
  String call(String key) => '{{$key}}';
}
