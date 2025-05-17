import 'package:accounting_module/pages/chart_of_account/chart_of_account.dart';
import 'package:accounting_module/pages/master/unit/unit_master.dart';
import 'package:accounting_module/pages/purchase_order/purchase_order.dart';
import 'package:accounting_module/pages/quotation/quotation.dart';
import 'package:accounting_module/pages/quotation/quotation_list.dart';
import 'package:flutter/material.dart';
import 'package:accounting_module/pages/home/home.dart';

const baseRoutePath = '/accounting';

class RoutePaths {
  static String home = '$baseRoutePath/home';
  static String chartOfAccount = '$baseRoutePath/chart-of-account';
  static String unitMaster = '$baseRoutePath/master/unit';
  static String purchaseOrder = '$baseRoutePath/expense/purchase-order';
  static String quotationList = '$baseRoutePath/revenue/quotation-list';
  static String quotationManage = '$baseRoutePath/revenue/quotation-manage';
}

class RouteConfifg {
  static Map<String, WidgetBuilder> routes = {
    RoutePaths.home: (context) => const HomePage(),
    RoutePaths.chartOfAccount: (context) => ChartOfAccountPage(),
    RoutePaths.unitMaster: (context) => UnitMasterPage(),
    RoutePaths.purchaseOrder: (context) => PurchaseOrderPage(),
    RoutePaths.quotationList: (context) => QuotationListPage(),
    RoutePaths.quotationManage: (context) => QuotationPage()
  };
}
