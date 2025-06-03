import 'package:intl/intl.dart' show DateFormat;

class DateUtil {
  static String fmt(DateTime value, {String format = 'yyyy-MM-dd'}) =>
      DateFormat(format).format(value);

  static DateTime getMondayOfWeek(DateTime date) =>
      date.subtract(Duration(days: date.weekday - DateTime.monday));
}
