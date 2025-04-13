import 'package:accounting_module/models/unit_master.dart';

class UnitMasterResponseData extends UnitMasterData {
  UnitMasterResponseData({required super.unitCode, required super.unitName, required super.unitNameEn, required super.unitType});

  factory UnitMasterResponseData.fromJson(Map<String, dynamic> json) => UnitMasterResponseData(
    unitCode: json['unitCode'] ?? '',
    unitName: json['unitName'] ?? '',
    unitNameEn: json['unitNameEn'] ?? '',
    unitType: json['unitType'] ?? -1,
  );
}
