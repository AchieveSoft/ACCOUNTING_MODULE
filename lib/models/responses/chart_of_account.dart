class ChartOfAccountItemResponseData {
  final String accountCode;
  final String accountName;
  final String accountNameEn;
  final String description;
  final String descriptionEn;
  final String accountingCategoryCode;
  final String chartOfAccountLevelCode;
  final String parentAccountCode;
  final List<ChartOfAccountItemResponseData> childItems;

  ChartOfAccountItemResponseData({
    required this.accountCode,
    required this.accountName,
    required this.accountNameEn,
    required this.description,
    required this.descriptionEn,
    required this.accountingCategoryCode,
    required this.chartOfAccountLevelCode,
    required this.parentAccountCode,
    required this.childItems,
  });

  factory ChartOfAccountItemResponseData.fromJson(Map<String, dynamic> json) =>
      ChartOfAccountItemResponseData(
        accountCode: json['accountCode'] ?? '',
        accountName: json['accountName'] ?? '',
        accountNameEn: json['accountNameEn'] ?? '',
        description: json['description'] ?? '',
        descriptionEn: json['descriptionEn'] ?? '',
        accountingCategoryCode: json['accountingCategoryCode'] ?? '',
        chartOfAccountLevelCode: json['chartOfAccountLevelCode'] ?? '',
        parentAccountCode: json['parentAccountCode'] ?? '',
        childItems:
            (json['childItems'] as List<dynamic>)
                .map((item) => ChartOfAccountItemResponseData.fromJson(item))
                .toList(),
      );
}

class ChartOfAccountResponseData {
  final String categoryCode;
  final String categoryName;
  final String categoryNameEn;
  final List<ChartOfAccountItemResponseData> categoryItems;

  ChartOfAccountResponseData({
    required this.categoryCode,
    required this.categoryName,
    required this.categoryNameEn,
    required this.categoryItems,
  });

  factory ChartOfAccountResponseData.fromJson(Map<String, dynamic> json) =>
      ChartOfAccountResponseData(
        categoryCode: json['categoryCode'] ?? '',
        categoryName: json['categoryName'] ?? '',
        categoryNameEn: json['categoryNameEn'] ?? '',
        categoryItems:
            (json['categoryItems'] as List<dynamic>)
                .map((item) => ChartOfAccountItemResponseData.fromJson(item))
                .toList(),
      );
}
