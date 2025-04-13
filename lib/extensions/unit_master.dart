import 'package:accounting_module/models/unit_master.dart';

extension UnitMasterDataExtension on UnitMasterData {
  String get unitTypeLabel {
    if (unitType == 1) {
      return 'สินค้า';
    } else if (unitType == 2) {
      return 'บริการ';
    } else {
      return 'ไม่รู้จัก';
    }
  }
}
