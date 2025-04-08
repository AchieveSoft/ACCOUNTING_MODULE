import 'package:accounting_module/extensions/chart_of_account.dart';
import 'package:accounting_module/models/accounting_category.dart';
import 'package:accounting_module/models/chat_of_account.dart';
import 'package:accounting_module/models/responses/chart_of_account.dart';
import 'package:accounting_module/services/chart_of_account.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class ChartOfAccountBloc
    extends Bloc<ChartOfAccountEvent, ChartOfAccountState> {
  ChartOfAccountBloc() : super(ChartOfAccountInitState()) {
    on<ChartOfAccountGetDataEvent>(_onGetData);
    on<ChartOfAccountSelectItemEvent>(_onSelectItem);
    on<ChartOfAccountUpdateDataEvent>(_onUpdateData);
  }

  Future<void> _onGetData(
    ChartOfAccountGetDataEvent event,
    Emitter<ChartOfAccountState> emit,
  ) async {
    emit(ChartOfAccountLoadingState());

    final List<ChartOfAccountResponseData> response =
        await ChartOfAccountService.getData();

    List<ChartOfAccount> allItems = response.toFlatMap();

    emit(
      ChartOfAccountDataState(
        allItems: allItems,
        categoryItems: response.mapToChartOfAccountCategoryList(),
      ),
    );
  }

  Future<void> _onSelectItem(
    ChartOfAccountSelectItemEvent event,
    Emitter<ChartOfAccountState> emit,
  ) async {
    emit(ChartOfAccountLoadingState());

    var itemSelect =
        event.currentState.allItems
            .where((item) => item.referenceCode == event.referenceCode)
            .first;
    var subAccountItem =
        event.currentState.allItems
            .where((item) => item.referenceCode == itemSelect.parentCode)
            .first;
    var mainAccountItem =
        event.currentState.allItems
            .where((item) => item.referenceCode == subAccountItem.parentCode)
            .firstOrNull;

    if (mainAccountItem != null) {
      emit(
        event.currentState.copyWith(
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
        event.currentState.copyWith(
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

  Future<void> _onUpdateData(
    ChartOfAccountUpdateDataEvent event,
    Emitter<ChartOfAccountState> emit,
  ) async {
    emit(event.newData);
  }
}
