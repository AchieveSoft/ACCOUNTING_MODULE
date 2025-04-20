import 'package:accounting_module/models/purchase_order.dart';
import 'package:accounting_module/shared/widgets/common_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class PurchaseOrderBloc extends Bloc<PurchaseOrderEvent, PurchaseOrderState> {
  PurchaseOrderBloc() : super(PurchaseOrderInitialState()) {
    on<PurchaseOrderGetDataEvent>(_onGetData);
    on<PurchaseOrderAddTransactionEvent>(_onAddTransaction);
    on<PurchaseOrderRemoveTransaction>(_onRemoveTransaction);
  }

  PurchaseOrderTransaction _buildDraftTransaction() => PurchaseOrderTransaction(
    productOrServiceCode: '',
    currentProductOrServiceName: '',
    qty: 1,
    currentUnitName: '',
    currentUnitNameEn: '',
    currentUnitPrice: 0.00,
    vatPercent: 7,
    discountTotal: 0.00,
    preVatTotal: 0.00,
    whtType: 1,
    whtPercent: 3,
    remark: '',
  );

  Future<void> _onGetData(
    PurchaseOrderGetDataEvent event,
    Emitter<PurchaseOrderState> emit,
  ) async {
    emit(PurchaseOrderLoadingState());
    CommonLoader.show();
    emit(
      PurchaseOrderDataState(
        items: [],
        createData: PurchaseOrder(
          docNo: 'PO-XXXXXXXX',
          status: 1,
          dueDate: '20301231',
          docReferrence: '',
          contractCode: '',
          taxStatus: 0,
          transactions: [_buildDraftTransaction()],
          remark: '',
          tagCode: '',
        ),
      ),
    );
    CommonLoader.hide();
  }

  Future<void> _onAddTransaction(
    PurchaseOrderAddTransactionEvent event,
    Emitter<PurchaseOrderState> emit,
  ) async {
    final PurchaseOrder currentCreateData = event.currentState.createData!;
    currentCreateData.transactions = [
      ...currentCreateData.transactions,
      _buildDraftTransaction(),
    ];

    emit(event.currentState.copyWith(createData: currentCreateData));
  }

  Future<void> _onRemoveTransaction(
    PurchaseOrderRemoveTransaction event,
    Emitter<PurchaseOrderState> emit,
  ) async {
    final PurchaseOrder createData = event.currentState.createData!;
    final List<PurchaseOrderTransaction> newTransactions =
        createData.transactions.indexed
            .where((entry) => entry.$1 != event.removeIndex)
            .map((item) => item.$2)
            .toList();

    createData.transactions = newTransactions;

    emit(event.currentState.copyWith(createData: createData));
  }
}
