part of 'bloc.dart';

abstract class PurchaseOrderState {}

class PurchaseOrderInitialState extends PurchaseOrderState {}

class PurchaseOrderLoadingState extends PurchaseOrderState {}

class PurchaseOrderDataState extends PurchaseOrderState {
  final List<PurchaseOrder> items;
  final PurchaseOrder? createData;

  PurchaseOrderDataState({required this.items, required this.createData});

  PurchaseOrderDataState copyWith({
    List<PurchaseOrder>? items,
    PurchaseOrder? createData,
  }) => PurchaseOrderDataState(
    items: items ?? this.items,
    createData: createData ?? this.createData,
  );
}
