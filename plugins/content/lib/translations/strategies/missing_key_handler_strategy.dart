export 'missing_key_handler_show_empty_string.dart';
export 'missing_key_handler_show_key_name.dart';

abstract class MissingKeyHandlerStrategy {
  String call(String key);
}
