import 'package:accounting_module/models/quotation.dart';
import 'package:accounting_module/services/quotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class QuotationBloc extends Bloc<QuotationEvent, QuotationState> {
  QuotationBloc() : super(QuotationInitialState()) {
    on<QuotationGetItemEvent>(_onGetItems);
  }

  Future<void> _getItems(Emitter<QuotationState> emit) async {
    emit(QuotationLoadingState());

    final items = await QuotationService.getItems();

    emit(QuotationDataState(items: items));
  }

  Future<void> _onGetItems(
    QuotationGetItemEvent event,
    Emitter<QuotationState> emit,
  ) async {
    await _getItems(emit);
  }
}
