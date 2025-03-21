import 'package:intl/intl.dart'; 

class ConvertDateTime {
  static String formatTimeStampToString(DateTime dateTime, bool enableTime,
      {String formatStyle = 'dd/MM/yyyy'}) {
    if (enableTime) formatStyle = 'dd/MM/yyyy hh:mm:ss a';
    return DateFormat(formatStyle).format(dateTime);
  }

  static DateTime addDateTimeForFireBase({
    required DateTime dateTime,
    required Duration duration,
  }) {
    return dateTime.add(duration);
  }

  static DateTime subtractDateTimeForFireBase({
    required DateTime dateTime,
    required Duration duration,
  }) {
    return dateTime.subtract(duration);
  }

  static DateTime formatDateToDateTimeForFireBase({required DateTime dateTime}) {
    DateTime time = DateTime.now();
    DateTime tempDateTime = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        time.hour,
        time.minute,
        time.second,
        time.millisecond,
        time.microsecond);
    return tempDateTime;
  }
}