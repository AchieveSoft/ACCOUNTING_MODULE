class QuotationTransaction {
  String productOrServiceCode;
  String currentProductOrServiceName;
  String currentProductOrServiceNameEn;
  String qty;
  String currentUnitName;
  String currentUnitNameEn;
  double currentUnitPrice;
  int vatPercent;
  double discountTotal;
  double preVatTotal;
  int whtType;
  int whtPercent;
  String remark;

  QuotationTransaction({
    required this.productOrServiceCode,
    required this.currentProductOrServiceName,
    required this.currentProductOrServiceNameEn,
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

  factory QuotationTransaction.fromJson(Map<String, dynamic> json) {
    return QuotationTransaction(
      productOrServiceCode: json['productOrServiceCode'],
      currentProductOrServiceName: json['currentProductOrServiceName'],
      currentProductOrServiceNameEn: json['currentProductOrServiceNameEn'],
      qty: json['qty'],
      currentUnitName: json['currentUnitName'],
      currentUnitNameEn: json['currentUnitNameEn'],
      currentUnitPrice: json['currentUnitPrice'].toDouble(),
      vatPercent: json['vatPercent'],
      discountTotal: json['discountTotal'].toDouble(),
      preVatTotal: json['preVatTotal'].toDouble(),
      whtType: json['whtType'],
      whtPercent: json['whtPercent'],
      remark: json['remark'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productOrServiceCode': productOrServiceCode,
      'currentProductOrServiceName': currentProductOrServiceName,
      'currentProductOrServiceNameEn': currentProductOrServiceNameEn,
      'qty': qty,
      'currentUnitName': currentUnitName,
      'currentUnitNameEn': currentUnitNameEn,
      'currentUnitPrice': currentUnitPrice,
      'vatPercent': vatPercent,
      'discountTotal': discountTotal,
      'preVatTotal': preVatTotal,
      'whtType': whtType,
      'whtPercent': whtPercent,
      'remark': remark,
    };
  }
}

class Quotation {
  String docCode;
  int docStatus;
  String acceptDate;
  String effectiveDate;
  String expireDate;
  String? docRef;
  String contractCode;
  double contractCredit;
  int taxStatus;
  List<QuotationTransaction> transactions;
  String remark;
  String tagCode;
  double total;
  String createBy;
  DateTime createDate;
  String updateBy;
  DateTime updateDate;
  List<String>? attachmentFiles;

  Quotation({
    required this.docCode,
    required this.docStatus,
    required this.acceptDate,
    required this.effectiveDate,
    required this.expireDate,
    this.docRef,
    required this.contractCode,
    required this.contractCredit,
    required this.taxStatus,
    required this.transactions,
    required this.remark,
    required this.tagCode,
    required this.total,
    required this.createBy,
    required this.createDate,
    required this.updateBy,
    required this.updateDate,
    this.attachmentFiles,
  });

  factory Quotation.fromJson(Map<String, dynamic> json) {
    return Quotation(
      docCode: json['docCode'],
      docStatus: json['docStatus'],
      acceptDate: json['acceptDate'],
      effectiveDate: json['effectiveDate'],
      expireDate: json['expireDate'],
      docRef: json['docRef'],
      contractCode: json['contractCode'],
      contractCredit: json['contractCredit'].toDouble(),
      taxStatus: json['taxStatus'],
      transactions: (json['transactions'] as List)
          .map((transaction) => QuotationTransaction.fromJson(transaction))
          .toList(),
      remark: json['remark'],
      tagCode: json['tagCode'],
      total: json['total'],
      createBy: json['createBy'],
      createDate: DateTime.parse(json['createDate']),
      updateBy: json['updateBy'],
      updateDate: DateTime.parse(json['updateDate']),
      attachmentFiles: json['attachmentFiles'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docCode': docCode,
      'docStatus': docStatus,
      'acceptDate': acceptDate,
      'effectiveDate': effectiveDate,
      'expireDate': expireDate,
      'docRef': docRef,
      'contractCode': contractCode,
      'contractCredit': contractCredit,
      'taxStatus': taxStatus,
      'transactions': transactions.map((transaction) => transaction.toJson()).toList(),
      'remark': remark,
      'tagCode': tagCode,
      'total': total,
      'createBy': createBy,
      'createDate': createDate.toIso8601String(),
      'updateBy': updateBy,
      'updateDate': updateDate.toIso8601String(),
    };
  }
}