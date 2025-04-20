part of 'bloc.dart';

abstract class PurchaseOrderState {}

class PurchaseOrderInitialState extends PurchaseOrderState {}

class PurchaseOrderLoadingState extends PurchaseOrderState {}

class PurchaseOrderDataState extends PurchaseOrderState {
  final List<PurchaseOrder> items;
  final PurchaseOrder? createOrUpdateData;
  final bool isEdit;

  PurchaseOrderDataState({
    required this.items,
    required this.createOrUpdateData,
    required this.isEdit,
  });

  PurchaseOrderDataState copyWith({
    List<PurchaseOrder>? items,
    PurchaseOrder? createOrUpdateData,
    bool? isEdit,
  }) => PurchaseOrderDataState(
    items: items ?? this.items,
    createOrUpdateData: createOrUpdateData ?? this.createOrUpdateData,
    isEdit: isEdit ?? this.isEdit,
  );
}
