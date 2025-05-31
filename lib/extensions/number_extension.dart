import 'package:accounting_module/utils/number_util.dart';

extension NumberExtension on int {
  String fmt() => NumberUtil.fmt(this);
}
