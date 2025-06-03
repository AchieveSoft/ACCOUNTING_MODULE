import 'package:accounting_module/blocs/common/state_mixins.dart';
import 'package:accounting_module/constants.dart';
import 'package:accounting_module/extensions/datetime.dart';
import 'package:accounting_module/models/quotation.dart';
import 'package:accounting_module/models/responses/base_response.dart';
import 'package:accounting_module/services/document_service.dart';
import 'package:accounting_module/services/quotation.dart';
import 'package:accounting_module/shared/widgets/common_loader.dart';
import 'package:accounting_module/utils/date_util.dart';
import 'package:accounting_module/utils/dialog_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class QuotationBloc extends Bloc<QuotationEvent, QuotationState> {
  QuotationBloc() : super(QuotationInitialState()) {
    on<QuotationGetItemEvent>(_onGetItems);
    on<QuotationInitialCreatePageEvent>(_onInitialCreatePageEvent);
    on<QuotationAddTransactionEvent>(_onAddTransaction);
    on<QuotationRemoveTransaction>(_onRemoveTransaction);
    on<QuotationViewDetailEvent>(_onViewDetail);
    on<QuotationManualTriggerEvent>(_onManualTrigger);
    on<QuotationCreatOrUpdateEvent>(_onCreateOrUpdate);
    on<QuotationFilterEvent>(_onFilter);
  }

  Future<void> _onManualTrigger(
    QuotationManualTriggerEvent event,
    Emitter<QuotationState> emit,
  ) async {
    emit(event.currentState!.manualTrigger());
  }

  QuotationTransaction _buildDraftTransaction() => QuotationTransaction(
    productOrServiceCode: '',
    currentProductOrServiceName: '',
    currentProductOrServiceNameEn: '',
    qty: 1,
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

    final DateTime monday = DateUtil.getMondayOfWeek(DateTime.now());
    final DateTime next7Days = monday.add(Duration(days: 7));
    final QuotationFilterStateValue initialFilterCriteria =
        QuotationFilterStateValue(startDate: monday, endDate: next7Days);
    final state = QuotationDataState(
      docCodeGen: '',
      items: items,
      tempItems: items,
      filterValue: initialFilterCriteria,
    );

    await state.fetchProductAndServiceItems();
    emit(state);

    _onFilter(
      QuotationFilterEvent(
        currentState: state,
        startDate: monday,
        endDate: next7Days,
      ),
      emit,
    );
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

    DateTime now = DateTime.now();
    DateTime nextDay = now.add(Duration(days: 1));

    Quotation createData = Quotation(
      docCode: value,
      docStatus: 1,
      acceptDate: '',
      effectiveDate: now.toYYYYMMDD(),
      expireDate: nextDay.toYYYYMMDD(),
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

    if (event.currentState == null) {
      await state.fetchProductAndServiceItems();
    }

    emit(state);
    CommonLoader.hide();
  }

  Future<void> _onAddTransaction(
    QuotationAddTransactionEvent event,
    Emitter<QuotationState> emit,
  ) async {
    final Quotation currentCreateData = event.currentState!.createOrUpdateData!;
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

  Future<void> _onViewDetail(
    QuotationViewDetailEvent event,
    Emitter<QuotationState> emit,
  ) async {
    event.currentState!.fetchProductAndServiceItems();
    emit(event.currentState!.copyWith(createOrUpdateData: event.data));
  }

  Future<void> _onCreateOrUpdate(
    QuotationCreatOrUpdateEvent event,
    Emitter<QuotationState> emit,
  ) async {
    emit(QuotationLoadingState());

    event.createOrUpdateData.total = event.currentState!.totalAmount;

    CommonLoader.show();
    final BaseResponse<String> response = await QuotationService.create(
      event.createOrUpdateData,
    );
    CommonLoader.hide();

    if (response.success) {
      Dialogutil.showAlertDiaglog('ดำเนินการสำเร็จ', 'บันทึกข้อมูลสำเร็จ');
      emit(event.currentState!);
    } else {
      Dialogutil.showAlertDiaglog('ดำเนินการไม่สำเร็จ', response.message);
    }
  }

  Future<void> _onFilter(
    QuotationFilterEvent event,
    Emitter<QuotationState> emit,
  ) async {
    QuotationFilterStateValue filterCriteria = QuotationFilterStateValue(
      docNo: event.docNo,
      remark: event.remark,
      startDate: event.startDate,
      endDate: event.endDate,
    );

    if (event.currentState?.filterValue != null) {
      filterCriteria = event.currentState!.filterValue!.merge(filterCriteria);
    }

    List<Quotation> newItems = event.currentState!.tempItems!;

    if (filterCriteria.docNo?.isNotEmpty == true) {
      newItems =
          newItems
              .where(
                (item) => item.docCode.toLowerCase().contains(
                  filterCriteria.docNo!.toLowerCase(),
                ),
              )
              .toList();
    }

    if (filterCriteria.startDate != null) {
      newItems =
          newItems.where((item) {
            final DateTime effectiveDate =
                DateTime.parse(item.effectiveDate).toDateOnly();
            final DateTime startDate = filterCriteria.startDate!.toDateOnly();

            return effectiveDate == startDate ||
                effectiveDate.isAfter(startDate);
          }).toList();
    }

    if (filterCriteria.endDate != null) {
      newItems =
          newItems.where((item) {
            final DateTime expireDate =
                DateTime.parse(item.expireDate).toDateOnly();
            final DateTime endDate = filterCriteria.endDate!.toDateOnly();

            return expireDate == endDate || expireDate.isBefore(endDate);
          }).toList();
    }

    emit(
      event.currentState!.copyWith(
        items: newItems,
        filterValue: filterCriteria,
      ),
    );
  }
}
