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

class ChartOfAccountDataState extends ChartOfAccountState {
  final List<ChartOfAccount> allItems;
  final List<AccountingCategory> categoryItems;
  final ChartOfAccountItemSelected? currentItemSelect;
  final Map<String, dynamic>? createData;

  ChartOfAccountDataState({
    required this.allItems,
    required this.categoryItems,
    this.currentItemSelect,
    this.createData,
  });

  ChartOfAccountDataState copyWith({
    List<ChartOfAccount>? allItems,
    List<AccountingCategory>? categoryItems,
    ChartOfAccountItemSelected? currentItemSelect,
    Map<String, dynamic>? createData,
  }) => ChartOfAccountDataState(
    allItems: allItems ?? this.allItems,
    categoryItems: categoryItems ?? this.categoryItems,
    currentItemSelect: currentItemSelect ?? this.currentItemSelect,
    createData: createData ?? this.createData,
  );
}
