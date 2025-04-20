part of 'bloc.dart';

abstract class ChartOfAccountState {}

class ChartOfAccountInitState extends ChartOfAccountState {}

class ChartOfAccountLoadingState extends ChartOfAccountState {}

class ChartOfAccountItemSelected {
  final String mainAccountName;
  final String subAccountName;
  final String accountName;
  final String accountDescription;

  ChartOfAccountItemSelected({
    required this.mainAccountName,
    required this.subAccountName,
    required this.accountName,
    required this.accountDescription,
  });
}

class ChartOfAccountCreateData {
  String mainAccountCode = '';
  String accountCode = '';
  String accountName = '';
  String accountNameEn = '';
  String description = '';
  String descriptionEn = '';
  String accountingCategoryCode = '0d78bcc0-aada-4d4f-af53-e39061442697';
  String chartOfAccountLevelCode = '0d78bcc0-aada-4d4f-af53-e39061442697';
  String parentAccountCode = '';

  ChartOfAccountCreateData updateWith({
    String? mainAccountCode,
    String? accountCode,
    String? accountName,
    String? accountNameEn,
    String? description,
    String? descriptionEn,
    String? accountingCategoryCode = '0d78bcc0-aada-4d4f-af53-e39061442697',
    String? chartOfAccountLevelCode = '0d78bcc0-aada-4d4f-af53-e39061442697',
    String? parentAccountCode,
  }) {
    this.mainAccountCode = mainAccountCode ?? this.mainAccountCode;
    this.accountCode = accountCode ?? this.accountCode;
    this.accountName = accountName ?? this.accountName;
    this.accountNameEn = accountNameEn ?? this.accountNameEn;
    this.description = description ?? this.description;
    this.descriptionEn = descriptionEn ?? this.descriptionEn;
    this.parentAccountCode = parentAccountCode ?? this.parentAccountCode;

    return this;
  }
}

class ChartOfAccountDataState extends ChartOfAccountState {
  String? searchKeyword;
  final List<ChartOfAccount> allItems;
  final List<AccountingCategory> categoryItems;
  final ChartOfAccountItemSelected? currentItemSelect;
  ChartOfAccountCreateData? createOrUpdateData = ChartOfAccountCreateData();

  ChartOfAccountDataState({
    this.searchKeyword,
    required this.allItems,
    required this.categoryItems,
    this.currentItemSelect,
    this.createOrUpdateData,
  });

  ChartOfAccountDataState copyWith({
    String? searchKeyword,
    List<ChartOfAccount>? allItems,
    List<AccountingCategory>? categoryItems,
    ChartOfAccountItemSelected? currentItemSelect,
    ChartOfAccountCreateData? createOrUpdateData,
  }) => ChartOfAccountDataState(
    searchKeyword: searchKeyword ?? this.searchKeyword,
    allItems: allItems ?? this.allItems,
    categoryItems: categoryItems ?? this.categoryItems,
    currentItemSelect: currentItemSelect ?? this.currentItemSelect,
    createOrUpdateData: createOrUpdateData ?? this.createOrUpdateData,
  );
}
