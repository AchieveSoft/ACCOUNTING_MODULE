class PurchaseOrderTransaction {
  final String productOrServiceCode;
  final String currentProductOrServiceName;
  int qty;
  final String currentUnitName;
  final String currentUnitNameEn;
  double currentUnitPrice;
  final int vatPercent;
  final double discountTotal;
  final double preVatTotal;
  final int whtType;
  final int whtPercent;
  final String remark;

  PurchaseOrderTransaction({
    required this.productOrServiceCode,
    required this.currentProductOrServiceName,
    required this.qty,
    required this.currentUnitName,
    required this.currentUnitNameEn,
    required this.currentUnitPrice,
    required this.vatPercent,
    required this.discountTotal,
    required this.preVatTotal,
    required this.whtType,
    required this.whtPercent,
    required this.remark,
  });

  factory PurchaseOrderTransaction.fromJson(Map<String, dynamic> json) =>
      PurchaseOrderTransaction(
        productOrServiceCode: json['productOrServiceCode'] ?? '',
        currentProductOrServiceName: json['currentProductOrServiceName'] ?? '',
        qty: json['qty'] ?? 0,
        currentUnitName: json['currentUnitName'] ?? '',
        currentUnitNameEn: json['currentUnitNameEn'] ?? '',
        currentUnitPrice: json['currentUnitPrice'] ?? 0,
        vatPercent: json['vatPercent'] ?? 0,
        discountTotal: json['discountTotal'] ?? 0,
        preVatTotal: json['preVatTotal'] ?? '',
        whtType: json['whtType'] ?? 0,
        whtPercent: json['whtPercent'] ?? 0,
        remark: json['remark'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'productOrServiceCode': productOrServiceCode,
    'currentProductOrServiceName': currentProductOrServiceName,
    'qty': qty,
    'currentUnitName': currentUnitName,
    'currentUnitNameEn': currentUnitNameEn,
    'currentUnitPrice': currentUnitPrice,
    'vatPercent': vatPercent,
    'whtType': whtType,
    'whtPercent': whtPercent,
    'remark': remark,
  };
}

class PurchaseOrder {
  final String docNo;
  final int status;
  final String dueDate;
  final String docReferrence;
  final String contractCode;
  final int taxStatus;
  List<PurchaseOrderTransaction> transactions;
  final String remark;
  final String tagCode;

  PurchaseOrder({
    required this.docNo,
    required this.status,
    required this.dueDate,
    required this.docReferrence,
    required this.contractCode,
    required this.taxStatus,
    required this.transactions,
    required this.remark,
    required this.tagCode,
  });

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) => PurchaseOrder(
    docNo: json['docNo'] ?? '',
    status: json['status'] ?? 0,
    dueDate: json['dueDate'] ?? '',
    docReferrence: json['docReferrence'] ?? '',
    contractCode: json['contractCode'] ?? '',
    taxStatus: json['taxStatus'] ?? '',
    transactions:
        ((json['transactions'] ?? []) as List<dynamic>)
            .map((item) => PurchaseOrderTransaction.fromJson(item))
            .toList(),
    remark: json['remark'] ?? '',
    tagCode: json['tagCode'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'docNo': docNo,
    'status': status,
    'dueDate': dueDate,
    'docReferrence': docReferrence,
    'contractCode': contractCode,
    'taxStatus': taxStatus,
    'transactions': transactions.map((item) => item.toJson()).toList(),
    'remark': remark,
    'tagCode': tagCode,
  };
}
