import 'package:accounting_module/models/accounting_category.dart';
import 'package:accounting_module/models/chat_of_account.dart';
import 'package:accounting_module/models/responses/chart_of_account.dart';

extension ChartOfAccountResponseItemDataExtension
    on ChartOfAccountItemResponseData {
  ChartOfAccount mapChartOfAccountModel() {
    return ChartOfAccount(
      categoryCode: accountingCategoryCode,
      referenceCode: accountCode,
      parentCode: parentAccountCode,
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

  List<ChartOfAccount> toFlatMap() {
    List<ChartOfAccount> allItems = [];

    void collectAccounts(ChartOfAccount account) {
      allItems.add(
        ChartOfAccount(
          categoryCode: account.categoryCode,
          referenceCode: account.referenceCode,
          parentCode: account.parentCode,
          name: account.name,
          description: account.description,
          children: [],
        ),
      );

      for (ChartOfAccount childItem in account.children) {
        collectAccounts(childItem);
      }
    }

    for (ChartOfAccount item in mapToChartOfAccountList()) {
      collectAccounts(item);
    }

    return allItems;
  }
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

  List<ChartOfAccount> toFlatMap() {
    List<ChartOfAccount> allItems = [];

    for (var item in this) {
      allItems.addAll(item.categoryItems.toFlatMap());
    }

    return allItems;
  }
}
