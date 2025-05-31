import 'package:accounting_module/utils/date_util.dart';

extension DateTimeExtension on DateTime {
  String toYYYYMMDD() => DateUtil.fmt(this);
}
