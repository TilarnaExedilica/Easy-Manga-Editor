import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/app/tr/tr_keys.dart';

extension DateTimeExtensions on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      return TrKeys.yearsAgo
          .tr(args: [(difference.inDays / 365).floor().toString()]);
    } else if (difference.inDays > 30) {
      return TrKeys.monthsAgo
          .tr(args: [(difference.inDays / 30).floor().toString()]);
    } else if (difference.inDays > 0) {
      return TrKeys.daysAgo.tr(args: [difference.inDays.toString()]);
    } else if (difference.inHours > 0) {
      return TrKeys.hoursAgo.tr(args: [difference.inHours.toString()]);
    } else if (difference.inMinutes > 0) {
      return TrKeys.minutesAgo.tr(args: [difference.inMinutes.toString()]);
    } else {
      return TrKeys.justNow.tr();
    }
  }
}
