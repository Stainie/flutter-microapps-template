import 'dart:math';

import 'package:intl/intl.dart';

final superscriptMap = {
  0: '\u2070',
  1: '\u00B9',
  2: '\u00B2',
  3: '\u00B3',
  4: '\u2074',
  5: '\u2075',
  6: '\u2076',
  7: '\u2077',
  8: '\u2078',
  9: '\u2079',
};

extension NumExtension on num {
  String toPercent() => '${toFixedWithoutTrailingZeros(decimals: 2)}%';

  String toFixedWithoutTrailingZeros({
    int? decimals,
  }) {
    var formattedValue =
        decimals != null ? toStringAsFixed(decimals) : toString();
    formattedValue = formattedValue.replaceAll(RegExp(r'0*$'), '');
    if (formattedValue.endsWith('.')) {
      formattedValue = formattedValue.substring(0, formattedValue.length - 1);
    }

    return formattedValue;
  }

  String getNumberAbbreviation() {
    if (compareTo(1E6) < 0) {
      return '';
    }

    if (compareTo(1E9) < 0) {
      return 'M';
    }

    if (compareTo(1E12) < 0) {
      return 'B';
    }

    return 'T';
  }

  String toEuro({
    bool withSymbol = true,
    int minDecimals = 0,
    int? maxDecimals,
    int? decimals,
    int? maxDigits,
    bool useCompact = false,
  }) {
    var result = '';
    final string = toFixedWithoutTrailingZeros();
    var formatPattern = '#,##0';
    final decimalSeparatorIndex = string.indexOf('.');
    final hasDecimals = decimalSeparatorIndex != -1;
    final numberOfNonDecimalDigits = string
        .substring(
          0,
          hasDecimals ? decimalSeparatorIndex : string.length,
        )
        .length;
    final numberOfDecimals =
        hasDecimals ? string.length - decimalSeparatorIndex - 1 : 0;
    final isBelowOne = compareTo(1) < 0;
    var decimalsUsed = 0;

    var minDec = minDecimals;
    var maxDec = maxDecimals;

    if (decimals != null) {
      minDec = decimals;
      maxDec = decimals;
    }

    if (minDec > 0 || hasDecimals) {
      var maxDecimalsUsed = numberOfDecimals;

      if (maxDec != null) {
        maxDecimalsUsed = min(maxDec, maxDecimalsUsed);
      }

      if (maxDigits != null) {
        maxDecimalsUsed =
            min(maxDecimalsUsed, max(maxDigits - numberOfNonDecimalDigits, 0));
      }

      decimalsUsed = max(minDec, maxDecimalsUsed);

      if (decimalsUsed > 0) {
        final zeros = <String>[];

        for (var i = 0; i < decimalsUsed; i++) {
          if (i < minDec) {
            zeros.add('0');
          } else {
            zeros.add('#');
          }
        }

        formatPattern += '.${zeros.join()}';
      }
    }

    if (useCompact) {
      if (numberOfNonDecimalDigits > 8) {
        final abbreviation = getNumberAbbreviation();
        final abbreviationNumber =
            NumberFormat.compact().parse('1$abbreviation');
        final compactNumberString =
            (this / abbreviationNumber).toFixedWithoutTrailingZeros();

        result =
            '${compactNumberString.substring(0, min(9, compactNumberString.length))}$abbreviation';
      } else {
        result = NumberFormat(formatPattern).format(this);

        if (!isBelowOne &&
            minDec == 0 &&
            numberOfNonDecimalDigits >= max(5, maxDigits ?? 0) &&
            decimalsUsed > 0) {
          result = result.substring(
            0,
            result.length -
                decimalsUsed +
                (numberOfNonDecimalDigits == 5 ? 1 : -1),
          );
        } else if (isBelowOne && decimalsUsed > 6) {
          final superscriptNumber = result.length - 5;
          final superscriptString = superscriptNumber.toString();
          final superscriptFormatted = StringBuffer();

          for (var i = 0; i < superscriptString.length; i++) {
            superscriptFormatted
                .write(superscriptMap[int.parse(superscriptString[i])]);
          }

          result =
              '${result.substring(0, 3)}$superscriptFormatted${result.substring(result.length - 2, result.length)}';
        }
      }
    } else {
      result = NumberFormat(formatPattern).format(this);
    }

    return withSymbol ? '€$result' : result;
  }

  String toCrypto({
    bool useCompact = false,
    int? maxDecimals,
    int? maxDigits,
  }) {
    final isBelowOne = compareTo(1) < 0;
    return isBelowOne
        ? toFixedWithoutTrailingZeros(decimals: maxDecimals)
        : toEuro(
            withSymbol: false,
            useCompact: useCompact,
            maxDecimals: maxDecimals,
            maxDigits: maxDigits,
          );
  }
}
