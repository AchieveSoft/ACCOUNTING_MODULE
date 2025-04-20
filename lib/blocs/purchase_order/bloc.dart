
import 'package:accounting_module/models/purchase_order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class PurchaseOrderBloc extends Bloc<PurchaseOrderEvent, PurchaseOrderState> {
  PurchaseOrderBloc(): super(PurchaseOrderInitialState());
}