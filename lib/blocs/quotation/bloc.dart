import 'package:accounting_module/constants.dart';
import 'package:accounting_module/models/quotation.dart';
import 'package:accounting_module/services/document_service.dart';
import 'package:accounting_module/services/quotation.dart';
import 'package:accounting_module/shared/widgets/common_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class QuotationBloc extends Bloc<QuotationEvent, QuotationState> {
  QuotationBloc() : super(QuotationInitialState()) {
    on<QuotationGetItemEvent>(_onGetItems);
    on<QuotationInitialCreatePageEvent>(_onInitialCreatePageEvent);
  }

  Future<void> _getItems(Emitter<QuotationState> emit) async {
    emit(QuotationLoadingState());
    CommonLoader.show();

    final items = await QuotationService.getItems();

    CommonLoader.hide();
    emit(QuotationDataState(docCodeGen: '', items: items));
  }

  Future<void> _onGetItems(
    QuotationGetItemEvent event,
    Emitter<QuotationState> emit,
  ) async {
    await _getItems(emit);
  }

  Future<void> _onInitialCreatePageEvent(
    QuotationInitialCreatePageEvent event,
    Emitter<QuotationState> emit,
  ) async {
    emit(QuotationLoadingState());
    CommonLoader.show();

    final String value = await DocumentService.generateDocumentCode(
      Constants.documentTypes.quotation,
    );

    emit(
      event.currentState?.copyWith(docCodeGen: value) ??
          QuotationDataState(docCodeGen: value, items: []),
    );
    CommonLoader.hide();
  }
}
