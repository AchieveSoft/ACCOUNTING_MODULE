class ProductsAndServiceMaster {
  final String productAndServiceCode;
  final String unitCode;
  final String name;
  final String nameEn;
  final String description;
  final String descriptionEn;
  final double buyPriceUnit;
  final double salePriceUnit;
  final int vatBuyPercent;
  final int vatSalePercent;
  final String barCode;
  final String buyAccountCode;
  final String saleAccountCode;
  final String costEstimateAccountCode;
  final String imageBase64;
  final double initialCurrentQty;
  final DateTime purchaseDate;
  final int unitBalance;
  final int unitPriceBalance;

  ProductsAndServiceMaster({
    required this.productAndServiceCode,
    required this.unitCode,
    required this.name,
    required this.nameEn,
    required this.description,
    required this.descriptionEn,
    required this.buyPriceUnit,
    required this.salePriceUnit,
    required this.vatBuyPercent,
    required this.vatSalePercent,
    required this.barCode,
    required this.buyAccountCode,
    required this.saleAccountCode,
    required this.costEstimateAccountCode,
    required this.imageBase64,
    required this.initialCurrentQty,
    required this.purchaseDate,
    required this.unitBalance,
    required this.unitPriceBalance,
  });

  factory ProductsAndServiceMaster.fromJson(Map<String, dynamic> json) {
    return ProductsAndServiceMaster(
      productAndServiceCode: json['productAndServiceCode'],
      unitCode: json['unitCode'],
      name: json['name'],
      nameEn: json['nameEn'],
      description: json['description'],
      descriptionEn: json['descriptionEn'],
      buyPriceUnit: json['buyPriceUnit'].toDouble(),
      salePriceUnit: json['salePriceUnit'].toDouble(),
      vatBuyPercent: json['vatBuyPercent'],
      vatSalePercent: json['vatSalePercent'],
      barCode: json['barCode'],
      buyAccountCode: json['buyAccountCode'],
      saleAccountCode: json['saleAccountCode'],
      costEstimateAccountCode: json['costEstimateAccountCode'],
      imageBase64: json['imageBase64'],
      initialCurrentQty: json['initialCurrentQty'].toDouble(),
      purchaseDate: DateTime.parse(json['purchaseDate']),
      unitBalance: json['unitBalance'],
      unitPriceBalance: json['unitPriceBalance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productAndServiceCode': productAndServiceCode,
      'unitCode': unitCode,
      'name': name,
      'nameEn': nameEn,
      'description': description,
      'descriptionEn': descriptionEn,
      'buyPriceUnit': buyPriceUnit,
      'salePriceUnit': salePriceUnit,
      'vatBuyPercent': vatBuyPercent,
      'vatSalePercent': vatSalePercent,
      'barCode': barCode,
      'buyAccountCode': buyAccountCode,
      'saleAccountCode': saleAccountCode,
      'costEstimateAccountCode': costEstimateAccountCode,
      'imageBase64': imageBase64,
      'initialCurrentQty': initialCurrentQty,
      'purchaseDate': purchaseDate.toIso8601String(),
      'unitBalance': unitBalance,
      'unitPriceBalance': unitPriceBalance,
    };
  }
}
