import 'package:accounting_module/accounting_module.dart';
import 'package:accounting_module/configs/routes.dart';
import 'package:accounting_module/core/global_keys.dart';
import 'package:erp_flutter_core_module/erp_app.dart';
import 'package:flutter/material.dart';

class AccountingApp extends StatelessWidget {
  const AccountingApp({super.key});

  @override
  Widget build(BuildContext context) => ErpApp(
    navigatorKey: GlobalKeepings.navigator,
    [AccountingModule()],
    'Accounting',
    RoutePaths.chartOfAccount,
  );
}
