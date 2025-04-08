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
  }

  Future<void> _onGetData(
    ChartOfAccountGetDataEvent event,
    Emitter<ChartOfAccountState> emit,
  ) async {
    emit(ChartOfAccountLoadingState());

    final List<ChartOfAccountResponseData> response =
        await ChartOfAccountService.getData();

    emit(
      ChartOfAccountDataState(
        allItems: [],
        categoryItems: response.mapToChartOfAccountCategoryList(),
      ),
    );
  }
}
