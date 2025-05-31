import 'package:accounting_module/models/product_and_service_master.dart';

class ProductAndServiceResponse extends ProductsAndServiceMaster {
  ProductAndServiceResponse({
    required super.productAndServiceCode,
    required super.unitCode,
    required super.name,
    required super.nameEn,
    required super.description,
    required super.descriptionEn,
    required super.buyPriceUnit,
    required super.salePriceUnit,
    required super.vatBuyPercent,
    required super.vatSalePercent,
    required super.barCode,
    required super.buyAccountCode,
    required super.saleAccountCode,
    required super.costEstimateAccountCode,
    required super.imageBase64,
    required super.initialCurrentQty,
    required super.purchaseDate,
    required super.unitBalance,
    required super.unitPriceBalance,
  });
}
