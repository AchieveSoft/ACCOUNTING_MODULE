import 'package:accounting_module/blocs/chart_of_account/bloc.dart';
import 'package:accounting_module/blocs/common_scaffold/bloc.dart';
import 'package:accounting_module/blocs/purchase_order/bloc.dart';
import 'package:accounting_module/blocs/unit_master/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextExtension on BuildContext {
  CommonScaffoldBloc readCommonScaffoldBloc() => read<CommonScaffoldBloc>();

  ChartOfAccountBloc readChartOfAccountBloc() => read<ChartOfAccountBloc>();

  UnitMasterBloc readUnitMasterBloc() => read<UnitMasterBloc>();

  PurchaseOrderBloc readPurchaseOrderBloc() => read<PurchaseOrderBloc>();
}
