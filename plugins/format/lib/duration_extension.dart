import 'package:flutter/widgets.dart';

extension DurationExtension on Duration {
  String toMinMaxTime(
    Duration? max,
    String day,
    String hour,
    String minute,
    String second,
    String instant,
  ) {
    // desired output 1 - 3 working days
    try {
      final min = this;
      final isDay = min.inDays > 0;

      if (isDay) {
        if (max == null) {
          return '${min.inDays} $day';
        }

        return '${min.inDays} - ${max.inDays} $day';
      }

      final isHour = min.inHours > 0;

      if (isHour) {
        if (max == null) {
          return '${min.inHours} $hour';
        }

        return '${min.inHours} - ${max.inHours} $hour';
      }

      final isMinute = min.inMinutes > 0;

      if (isMinute) {
        if (max == null) {
          return '${min.inMinutes} $minute';
        }

        return '${min.inMinutes} - ${max.inMinutes} $minute';
      }

      final isSecond = min.inSeconds > 0;

      if (isSecond) {
        if (max == null) {
          return '${min.inSeconds} $second';
        }

        return '${min.inSeconds} - ${max.inSeconds} $second';
      }

      if (min.inSeconds == 0) {
        return instant;
      }

      return '';
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }
}
