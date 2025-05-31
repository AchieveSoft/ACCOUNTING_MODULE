import 'package:intl/intl.dart' show NumberFormat;

class NumberUtil {
  static String fmt(int value, {String format = '#,##0'}) =>
      NumberFormat(format).format(value);
}
