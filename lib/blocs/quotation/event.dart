part of 'bloc.dart';

abstract class QuotationEvent {}

class QuotationKeepingCurrentDataStateEventBase extends QuotationEvent {
  final QuotationDataState? currentState;

  QuotationKeepingCurrentDataStateEventBase({required this.currentState});
}

class QuotationGetItemEvent extends QuotationKeepingCurrentDataStateEventBase {
  QuotationGetItemEvent({required super.currentState});
}

class QuotationInitialListPageEvent
    extends QuotationKeepingCurrentDataStateEventBase {
  QuotationInitialListPageEvent({required super.currentState});
}

class QuotationInitialCreatePageEvent
    extends QuotationKeepingCurrentDataStateEventBase {
  QuotationInitialCreatePageEvent({required super.currentState});
}

class QuotationAddTransactionEvent
    extends QuotationKeepingCurrentDataStateEventBase {
  QuotationAddTransactionEvent({required super.currentState});
}

class QuotationRemoveTransaction
    extends QuotationKeepingCurrentDataStateEventBase {
  final int removeIndex;

  QuotationRemoveTransaction({
    required this.removeIndex,
    required super.currentState,
  });
}

class QuotationViewDetailEvent
    extends QuotationKeepingCurrentDataStateEventBase {
  final Quotation data;

  QuotationViewDetailEvent({required this.data, required super.currentState});
}

class QuotationManualTriggerEvent
    extends QuotationKeepingCurrentDataStateEventBase {
  QuotationManualTriggerEvent({required super.currentState});
}

class QuotationCreatOrUpdateEvent
    extends QuotationKeepingCurrentDataStateEventBase {
  final Quotation createOrUpdateData;
  final bool isUpdate;

  QuotationCreatOrUpdateEvent({
    required this.createOrUpdateData,
    this.isUpdate = false,
    required super.currentState,
  });
}

class QuotationFilterEvent extends QuotationKeepingCurrentDataStateEventBase {
  final String? docNo;
  final String? remark;
  final DateTime? startDate;
  final DateTime? endDate;

  QuotationFilterEvent({
    required super.currentState,
    this.docNo,
    this.remark,
    this.startDate,
    this.endDate,
  });
}
