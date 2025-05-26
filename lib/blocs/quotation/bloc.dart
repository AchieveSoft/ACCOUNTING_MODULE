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
    on<QuotationAddTransactionEvent>(_onAddTransaction);
    on<QuotationRemoveTransaction>(_onRemoveTransaction);
  }

    QuotationTransaction _buildDraftTransaction() => QuotationTransaction(
    productOrServiceCode: '',
    currentProductOrServiceName: '',
    currentProductOrServiceNameEn: '',
    qty: "1",
    currentUnitName: '',
    currentUnitNameEn: '',
    currentUnitPrice: 100,
    vatPercent: 7,
    discountTotal: 0.00,
    preVatTotal: 0.00,
    whtType: 1,
    whtPercent: 3,
    remark: '',
  );

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

    Quotation createData = Quotation(
      docCode: value,
      docStatus: 1,
      acceptDate: '',
      effectiveDate: '',
      expireDate: '',
      contractCode: '',
      contractCredit: 0,
      taxStatus: 0,
      transactions: [_buildDraftTransaction()],
      remark: '',
      tagCode: '',
      total: 0,
      createBy: '',
      createDate: DateTime.now(),
      updateBy: '',
      updateDate: DateTime.now(),
    );

    QuotationDataState state =
        event.currentState?.copyWith(
          docCodeGen: value,
          createOrUpdateData: createData,
        ) ??
        QuotationDataState(
          docCodeGen: value,
          items: event.currentState?.items ?? [],
          createOrUpdateData: createData,
        );

    emit(state);
    CommonLoader.hide();
  }

  Future<void> _onAddTransaction(
    QuotationAddTransactionEvent event,
    Emitter<QuotationState> emit,
  ) async {
    final Quotation currentCreateData =
        event.currentState!.createOrUpdateData!;
    currentCreateData.transactions = [
      ...currentCreateData.transactions,
      _buildDraftTransaction(),
    ];

    emit(event.currentState!.copyWith(createOrUpdateData: currentCreateData));
  }

  Future<void> _onRemoveTransaction(
    QuotationRemoveTransaction event,
    Emitter<QuotationState> emit,
  ) async {
    final Quotation createOrUpdateData =
        event.currentState!.createOrUpdateData!;
    final List<QuotationTransaction> newTransactions =
        createOrUpdateData.transactions.indexed
            .where((entry) => entry.$1 != event.removeIndex)
            .map((item) => item.$2)
            .toList();

    createOrUpdateData.transactions = newTransactions;

    emit(event.currentState!.copyWith(createOrUpdateData: createOrUpdateData));
  }
}
