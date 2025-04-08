part of 'bloc.dart';

abstract class ChartOfAccountEvent {}

class ChartOfAccountGetDataEvent extends ChartOfAccountEvent {}

class ChartOfAccountSelectItemEvent extends ChartOfAccountEvent {
  final ChartOfAccountDataState currentState;
  final String referenceCode;

  ChartOfAccountSelectItemEvent({required this.currentState, required this.referenceCode});
}

class ChartOfAccountUpdateDataEvent extends ChartOfAccountEvent {
  final ChartOfAccountDataState newData;

  ChartOfAccountUpdateDataEvent({required this.newData});
}