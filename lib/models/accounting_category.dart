import 'package:accounting_module/models/chat_of_account.dart';

class AccountingCategory {
  final String referenceCode;
  final String name;
  final List<ChartOfAccount> chartOfAccountings;

  AccountingCategory({
    required this.referenceCode,
    required this.name,
    required this.chartOfAccountings,
  });
}
