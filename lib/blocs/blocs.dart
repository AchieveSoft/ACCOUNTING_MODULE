import 'package:accounting_module/blocs/chart_of_account/bloc.dart';
import 'package:accounting_module/blocs/common_scaffold/bloc.dart';
import 'package:accounting_module/blocs/purchase_order/bloc.dart';
import 'package:accounting_module/blocs/quotation/bloc.dart';
import 'package:accounting_module/blocs/unit_master/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart' show SingleChildWidget;

class AllBlocs {
  static List<SingleChildWidget> items = [
    BlocProvider(create: (context) => CommonScaffoldBloc()),
    BlocProvider(create: (context) => ChartOfAccountBloc()),
    BlocProvider(create: (context) => UnitMasterBloc()),
    BlocProvider(create: (context) => PurchaseOrderBloc()),
    BlocProvider(create: (context) => QuotationBloc()),
  ];
}
