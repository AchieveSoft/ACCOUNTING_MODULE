import 'package:accounting_module/extensions/chart_of_account.dart';
import 'package:accounting_module/models/accounting_category.dart';
import 'package:accounting_module/models/chat_of_account.dart';
import 'package:accounting_module/models/requests/chart_of_account.dart';
import 'package:accounting_module/models/responses/chart_of_account.dart';
import 'package:accounting_module/services/chart_of_account.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class ChartOfAccountBloc
    extends Bloc<ChartOfAccountEvent, ChartOfAccountState> {
  ChartOfAccountBloc() : super(ChartOfAccountInitState()) {
    on<ChartOfAccountGetDataEvent>(_onGetData);
    on<ChartOfAccountSearchEvent>(_onSearch);
    on<ChartOfAccountSelectItemEvent>(_onSelectItem);
    on<ChartOfAccountUpdateDataEvent>(_onUpdateData);
    on<ChartOfAccountCreateAccountEvent>(_onCreateAccount);
  }

  void _setItemFromSelectedItem(
    ChartOfAccountDataState currentState,
    String referenceCode,
    Emitter<ChartOfAccountState> emit,
  ) {
    var itemSelect =
        currentState.allItems
            .where((item) => item.referenceCode == referenceCode)
            .first;
    var subAccountItem =
        currentState.allItems
            .where((item) => item.referenceCode == itemSelect.parentCode)
            .first;
    var mainAccountItem =
        currentState.allItems
            .where((item) => item.referenceCode == subAccountItem.parentCode)
            .firstOrNull;

    if (mainAccountItem != null) {
      emit(
        currentState.copyWith(
          currentItemSelect: ChartOfAccountItemSelected(
            mainAccountName: mainAccountItem.name,
            subAccountName: subAccountItem.name,
            accountName: itemSelect.name,
            accountDescription: itemSelect.description,
          ),
        ),
      );
    } else {
      emit(
        currentState.copyWith(
          currentItemSelect: ChartOfAccountItemSelected(
            mainAccountName: subAccountItem.name,
            subAccountName: itemSelect.name,
            accountName: itemSelect.name,
            accountDescription: itemSelect.description,
          ),
        ),
      );
    }
  }

  Future<void> _getData(
    Emitter<ChartOfAccountState> emit, {
    String? searchKeyword,
  }) async {
    emit(ChartOfAccountLoadingState());

    final List<ChartOfAccountResponseData> response =
        searchKeyword?.isNotEmpty == true
            ? await ChartOfAccountService.getDataWithSearch(searchKeyword!)
            : await ChartOfAccountService.getData();
    final List<AccountingCategory> categoryItems =
        response.mapToChartOfAccountCategoryList();

    List<ChartOfAccount> allItems = response.toFlatMap();
    final ChartOfAccountDataState currentState = ChartOfAccountDataState(
      allItems: allItems,
      categoryItems: categoryItems,
    );

    emit(currentState);

    ChartOfAccount? firstSelect =
        allItems
            .where(
              (item) =>
                  item.parentCode?.isNotEmpty == true && item.children.isEmpty,
            )
            .firstOrNull;

    if (firstSelect != null) {
      _setItemFromSelectedItem(currentState, firstSelect.referenceCode, emit);
    }
  }

  Future<void> _onGetData(
    ChartOfAccountGetDataEvent event,
    Emitter<ChartOfAccountState> emit,
  ) async {
    await _getData(emit);
  }

  Future<void> _onSearch(
    ChartOfAccountSearchEvent event,
    Emitter<ChartOfAccountState> emit,
  ) async {
    await _getData(emit, searchKeyword: event.searchKeyword);
  }

  Future<void> _onSelectItem(
    ChartOfAccountSelectItemEvent event,
    Emitter<ChartOfAccountState> emit,
  ) async {
    emit(ChartOfAccountLoadingState());
    _setItemFromSelectedItem(event.currentState, event.referenceCode, emit);
  }

  Future<void> _onUpdateData(
    ChartOfAccountUpdateDataEvent event,
    Emitter<ChartOfAccountState> emit,
  ) async {
    emit(event.newData);
  }

  Future<void> _onCreateAccount(
    ChartOfAccountCreateAccountEvent event,
    Emitter<ChartOfAccountState> emit,
  ) async {
    emit(ChartOfAccountLoadingState());
    await ChartOfAccountService.create(
      ChartOfAccountRequest(
        accountCode: event.currentState.createData!.accountCode,

        accountName: event.currentState.createData!.accountName,
        accountNameEn: event.currentState.createData!.accountNameEn,
        description: event.currentState.createData!.description,
        descriptionEn: event.currentState.createData!.descriptionEn,
        parentAccountCode: event.currentState.createData!.parentAccountCode,
      ).toJson(),
    );
    emit(event.currentState);
  }
}
