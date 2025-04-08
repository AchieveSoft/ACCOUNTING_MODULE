import 'package:accounting_module/pages/chart_of_account/chart_of_account.dart';
import 'package:flutter/material.dart';
import 'package:accounting_module/pages/home/home.dart';

const baseRoutePath = '/accounting';

class RoutePaths {
  static String home = '$baseRoutePath/home';
  static String chartOfAccount = '$baseRoutePath/chart-of-account';
}

class RouteConfifg {
  static Map<String, WidgetBuilder> routes = {
    RoutePaths.home: (context) => const HomePage(),
    RoutePaths.chartOfAccount: (context) => ChartOfAccountPage(),
  };
}
