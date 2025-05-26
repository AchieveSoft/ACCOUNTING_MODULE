part of 'bloc.dart';

abstract class QuotationEvent {}

class QuotationGetItemEvent extends QuotationEvent {}

class QuotationKeepingCurrentDataStateEventBase extends QuotationEvent {
  final QuotationDataState? currentState;

  QuotationKeepingCurrentDataStateEventBase({required this.currentState});
}

class QuotationInitialCreatePageEvent extends QuotationKeepingCurrentDataStateEventBase {
  QuotationInitialCreatePageEvent({required super.currentState});
}

class QuotationAddTransactionEvent extends QuotationKeepingCurrentDataStateEventBase {
  QuotationAddTransactionEvent({required super.currentState});
}

class QuotationRemoveTransaction extends QuotationKeepingCurrentDataStateEventBase {
  final int removeIndex;
  
  QuotationRemoveTransaction({required this.removeIndex, required super.currentState});
}

