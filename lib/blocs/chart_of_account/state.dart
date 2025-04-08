part of 'bloc.dart';

abstract class ChartOfAccountState {}

class ChartOfAccountInitState extends ChartOfAccountState {}

class ChartOfAccountLoadingState extends ChartOfAccountState {}

class ChartOfAccountDataState extends ChartOfAccountState {
  final List<ChartOfAccount> allItems;
  final List<AccountingCategory> categoryItems;

  ChartOfAccountDataState({
    required this.allItems,
    required this.categoryItems,
  });

  ChartOfAccountDataState copyWith({
    List<ChartOfAccount>? allItems,
    List<AccountingCategory>? categoryItems,
  }) => ChartOfAccountDataState(
    allItems: allItems ?? this.allItems,
    categoryItems: categoryItems ?? this.categoryItems,
  );
}
