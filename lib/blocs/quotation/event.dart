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
