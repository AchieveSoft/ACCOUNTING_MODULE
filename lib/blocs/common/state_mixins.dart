import 'package:accounting_module/models/product_and_service_master.dart';
import 'package:accounting_module/services/product_and_service.dart';

mixin ManualTriggerStateMixin {
  abstract int triggerNum;

  void callManualTrigger(ManualTriggerStateMixin oldMixin) =>
      triggerNum = oldMixin.triggerNum + 1;

  void keepManualTriggerStateWhenCopy(ManualTriggerStateMixin oldMixin) =>
      triggerNum = oldMixin.triggerNum;
}

mixin ProductAndServiceStateMixin {
  List<ProductsAndServiceMaster>? _productAndServiceItems;

  List<ProductsAndServiceMaster> get productAndServiceItems {
    return _productAndServiceItems!;
  }

  Future<void> fetchProductAndServiceItems() async {
    try {
      _productAndServiceItems = await ProductAndServiceService.getItems();
    } catch (_) {}
  }

  void keepProductAndServiceItemWhenCopy(
    ProductAndServiceStateMixin oldMixin,
  ) => _productAndServiceItems = oldMixin._productAndServiceItems;
}
