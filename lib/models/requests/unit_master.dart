import 'package:accounting_module/models/unit_master.dart';

class UnitMasterRequest extends UnitMasterData {
  UnitMasterRequest({
    required super.unitCode,
    required super.unitName,
    required super.unitNameEn,
    required super.unitType,
  });

  Map<String, dynamic> toJson() => {
    'unitCode': unitCode,
    'unitName': unitName,
    'unitNameEn': unitNameEn,
    'type': unitType,
  };
}
