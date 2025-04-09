class ChartOfAccountRequest {
  final String accountCode;
  final String accountName;
  final String accountNameEn;
  final String description;
  final String descriptionEn;
  final String accountingCategoryCode = '0d78bcc0-aada-4d4f-af53-e39061442697';
  final String chartOfAccountLevelCode = '0d78bcc0-aada-4d4f-af53-e39061442697';
  final String parentAccountCode;

  ChartOfAccountRequest({
    required this.accountCode,
    required this.accountName,
    required this.accountNameEn,
    required this.description,
    required this.descriptionEn,
    required this.parentAccountCode,
  });

  Map<String, dynamic> toJson() => {
    'accountCode': accountCode,
    'accountName': accountName,
    'accountNameEn': accountNameEn,
    'description': description,
    'descriptionEn': descriptionEn,
    'accountingCategoryCode': accountingCategoryCode,
    'chartOfAccountLevelCode': chartOfAccountLevelCode,
    'parentAccountCode': parentAccountCode,
  };
}
