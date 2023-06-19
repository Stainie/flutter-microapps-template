library format;

import 'package:intl/date_symbol_data_local.dart';

export 'datetime_extension.dart';
export 'decimal_extension.dart';
export 'duration_extension.dart';
export 'iterable_extension.dart';
export 'num_extension.dart';
export 'string_extension.dart';

Future<void> setupFormat() async {
  await initializeDateFormatting();
}
