abstract class DateService {
  String formatDateTime(DateTime value,
      {bool short = false, bool showSeconds = false});

  DateTime dateTimeFromMilliseconds(int milliseconds, {bool utc = false});

  String formatDate(DateTime value);

  String timeAgo(DateTime value);

  String duration(Duration value, {bool forceHour = true, bool forceMinutes = true});
}
