part of 'bloc.dart';


abstract class PurchaseOrderEvent {}

class PurchaseOrderGetDataEvent extends PurchaseOrderEvent {}

class PurchaseOrderInitialCreateEvent extends PurchaseOrderEvent {
  final PurchaseOrderDataState currentState;

  PurchaseOrderInitialCreateEvent({required this.currentState});
}

class PurchaseOrderAddTransactionEvent extends PurchaseOrderEvent {
  final PurchaseOrderDataState currentState;
  
  PurchaseOrderAddTransactionEvent({required this.currentState});
}

class PurchaseOrderRemoveTransaction extends PurchaseOrderEvent {
  final int removeIndex;
  final PurchaseOrderDataState currentState;
  
  PurchaseOrderRemoveTransaction({required this.removeIndex, required this.currentState});
}
