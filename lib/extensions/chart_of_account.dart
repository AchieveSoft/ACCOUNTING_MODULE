import 'package:accounting_module/models/accounting_category.dart';
import 'package:accounting_module/models/chat_of_account.dart';
import 'package:accounting_module/models/responses/chart_of_account.dart';

extension ChartOfAccountResponseItemDataExtension
    on ChartOfAccountItemResponseData {
  ChartOfAccount mapChartOfAccountModel() {
    return ChartOfAccount(
      categoryCode: accountingCategoryCode,
      referenceCode: accountCode,
      name: accountName,
      description: description,
      children:
          childItems.map((item) => item.mapChartOfAccountModel()).toList(),
    );
  }
}

extension ChartOfAccountResponseItemDataListExtension
    on List<ChartOfAccountItemResponseData> {
  List<ChartOfAccount> mapToChartOfAccountList() =>
      map((item) => item.mapChartOfAccountModel()).toList();
}

extension ChartOfAccountResponseDataExtension on ChartOfAccountResponseData {
  AccountingCategory mapToChartOfAccountCategory() {
    return AccountingCategory(
      referenceCode: categoryCode,
      name: categoryName,
      chartOfAccountings: categoryItems.mapToChartOfAccountList(),
    );
  }
}

extension ChartOfAccountResponseDataListExtension
    on List<ChartOfAccountResponseData> {
  List<AccountingCategory> mapToChartOfAccountCategoryList() =>
      map((item) => item.mapToChartOfAccountCategory()).toList();

    
}
