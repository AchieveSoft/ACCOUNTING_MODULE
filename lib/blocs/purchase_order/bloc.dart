import 'package:accounting_module/models/purchase_order.dart';
import 'package:accounting_module/models/responses/base_response.dart';
import 'package:accounting_module/services/purchase_order.dart';
import 'package:accounting_module/shared/widgets/common_loader.dart';
import 'package:accounting_module/utils/dialog_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class PurchaseOrderBloc extends Bloc<PurchaseOrderEvent, PurchaseOrderState> {
  PurchaseOrderBloc() : super(PurchaseOrderInitialState()) {
    on<PurchaseOrderGetDataEvent>(_onGetData);
    on<PurchaseOrderAddTransactionEvent>(_onAddTransaction);
    on<PurchaseOrderRemoveTransaction>(_onRemoveTransaction);
    on<PurchaseOrderCreateEvent>(_onCreate);
  }

  PurchaseOrderTransaction _buildDraftTransaction() => PurchaseOrderTransaction(
    productOrServiceCode: '',
    currentProductOrServiceName: '',
    currentAccountCode: '',
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
        createOrUpdateData: PurchaseOrder(
          docNo: 'QO-XXXXXXXX',
          status: 1,
          dueDate: '20301231',
          docReferrence: '',
          contractCode: '',
          taxStatus: 0,
          transactions: [_buildDraftTransaction()],
          remark: '',
          tagCode: '',
        ),
        isEdit: false,
      ),
    );
    CommonLoader.hide();
  }

  Future<void> _onAddTransaction(
    PurchaseOrderAddTransactionEvent event,
    Emitter<PurchaseOrderState> emit,
  ) async {
    final PurchaseOrder currentCreateData =
        event.currentState.createOrUpdateData!;
    currentCreateData.transactions = [
      ...currentCreateData.transactions,
      _buildDraftTransaction(),
    ];

    emit(event.currentState.copyWith(createOrUpdateData: currentCreateData));
  }

  Future<void> _onRemoveTransaction(
    PurchaseOrderRemoveTransaction event,
    Emitter<PurchaseOrderState> emit,
  ) async {
    final PurchaseOrder createOrUpdateData =
        event.currentState.createOrUpdateData!;
    final List<PurchaseOrderTransaction> newTransactions =
        createOrUpdateData.transactions.indexed
            .where((entry) => entry.$1 != event.removeIndex)
            .map((item) => item.$2)
            .toList();

    createOrUpdateData.transactions = newTransactions;

    emit(event.currentState.copyWith(createOrUpdateData: createOrUpdateData));
  }

  Future<void> _onCreate(
    PurchaseOrderCreateEvent event,
    Emitter<PurchaseOrderState> emit,
  ) async {
    emit(PurchaseOrderLoadingState());

    CommonLoader.show();
    final BaseResponse<String> response = await PurchaseOrderService.create(
      event.currentState.createOrUpdateData!,
    );
    CommonLoader.hide();

    if (response.success) {
      Dialogutil.showAlertDiaglog('ดำเนินการสำเร็จ', 'บันทึกข้อมูลสำเร็จ');
      emit(event.currentState);
    } else {
      Dialogutil.showAlertDiaglog('ดำเนินการไม่สำเร็จ', response.message);
    }
  }
}
