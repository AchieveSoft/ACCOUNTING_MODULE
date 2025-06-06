part of 'bloc.dart';

abstract class ChartOfAccountEvent {}

class ChartOfAccountGetDataEvent extends ChartOfAccountEvent {}

class ChartOfAccountSearchEvent extends ChartOfAccountEvent {
  final String searchKeyword;

  ChartOfAccountSearchEvent(this.searchKeyword);
}

class ChartOfAccountSelectItemEvent extends ChartOfAccountEvent {
  final ChartOfAccountDataState currentState;
  final String referenceCode;

  ChartOfAccountSelectItemEvent({required this.currentState, required this.referenceCode});
}

class ChartOfAccountUpdateDataEvent extends ChartOfAccountEvent {
  final ChartOfAccountDataState newData;

  ChartOfAccountUpdateDataEvent({required this.newData});
}

class ChartOfAccountCreateAccountEvent extends ChartOfAccountEvent {
  final ChartOfAccountDataState currentState;

  ChartOfAccountCreateAccountEvent({required this.currentState});
}
