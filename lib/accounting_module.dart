import 'package:accounting_module/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart' show SingleChildWidget;
import 'package:accounting_module/configs/routes.dart';
import 'package:erp_flutter_core_module/core/base_module.dart';
import 'package:erp_flutter_core_module/core/multi_language.dart';

class AccountingModule extends BaseModule {
  AccountingModule._internal();

  static final AccountingModule _instance = AccountingModule._internal();

  factory AccountingModule() => _instance;

  @override
  String moduleName = 'accounting';
  @override
  Map<String, WidgetBuilder> routes = RouteConfifg.routes;
  @override
  List<SingleChildWidget> blocs = AllBlocs.items;
  @override
  List<LanguageConfig> languageConfigs = [];
}
