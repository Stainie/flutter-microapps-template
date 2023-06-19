import 'dart:math';

import 'package:decimal/decimal.dart';

extension DecimalExtension on Decimal {
  String toFixedWithoutTrailingZeros(int decimals) {
    return toStringAsFixed(min(scale, decimals));
  }
}
