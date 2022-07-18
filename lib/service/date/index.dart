import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as t;

import '_interface.dart';

class DateServiceImpl extends DateService {
  final String locale;
  late DateFormat _timeFormat;
  late DateFormat _timeSecondsFormat;
  late DateFormat _dateFormat;
  late DateFormat _dateShortFormat;

  DateServiceImpl({required this.locale}) {
    _dateFormat = DateFormat.yMMMd(locale);
    _dateShortFormat = DateFormat.yMd(locale);
    _timeFormat = DateFormat.Hm(locale);
    _timeSecondsFormat = DateFormat.Hms(locale);
  }

  @override
  String formatDate(DateTime value) {
    return _dateFormat.format(value);
  }

  @override
  String formatDateTime(DateTime value, {bool short = false, bool showSeconds = false}) {
    String time;
    if (showSeconds) {
      time = _timeSecondsFormat.format(value);
    } else {
      time = _timeFormat.format(value);
    }

    if (short) {
      return "${_dateShortFormat.format(value)} $time";
    }

    return "${_dateFormat.format(value)} $time";
  }

  @override
  DateTime dateTimeFromMilliseconds(int milliseconds, {bool utc = false}) => DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: utc);

  @override
  String timeAgo(DateTime value) {
    return t.format(value);
  }

  @override
  String duration(Duration value, {bool forceHour = true, bool forceMinutes = true}) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitSeconds = twoDigits(value.inSeconds.remainder(60));

    final parts = <String>[];
    if (forceHour || value.inHours > 0) {
      String twoDigitHours = twoDigits(value.inHours.remainder(60));
      parts.add(twoDigitHours);
    }

    if (forceMinutes || value.inMinutes.remainder(60) > 0) {
      String twoDigitMinutes = twoDigits(value.inMinutes.remainder(60));
      parts.add(twoDigitMinutes);
    }

    parts.add(twoDigitSeconds);
    return parts.join(":");
  }
}
