import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

extension DateTimeExtension on DateTime {
  /// Returns the localized date according to the given [locale].
  ///
  /// Examples:
  /// 1) DateTime(2021, 1, 1).localized(Locale('nl', 'NL')) => '1 jan 2021'
  String todMMMyyyy(Locale locale) {
    return intl.DateFormat('d MMM yyyy', locale.toString()).format(this);
  }

  /// Returns the localized date with time according to the given [locale].
  ///
  /// Exampes:
  /// 1) DateTime(2021, 1, 1, 12, 34, 56).localized(Locale('nl', 'NL'))
  ///    => '1 januari 2021, 12:34'
  String todMMMMyyyyHHmm(Locale locale) {
    return intl.DateFormat('d MMMM yyyy, HH:mm', locale.toString())
        .format(this);
  }

  /// Returns the localized month and year according to the given [locale].
  ///
  /// Examples:
  /// 1) DateTime(2021, 1, 1).localized(Locale('nl', 'NL')) => 'januari ‘21'
  String toMMMMyy(Locale locale) {
    return intl.DateFormat('MMMM ‘yy', locale.toString()).format(this);
  }
}
