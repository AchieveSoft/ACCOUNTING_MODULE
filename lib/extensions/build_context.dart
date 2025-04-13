import 'package:accounting_module/blocs/chart_of_account/bloc.dart';
import 'package:accounting_module/blocs/unit_master/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextExtension on BuildContext {
  ChartOfAccountBloc readChartOfAccountBloc() => read<ChartOfAccountBloc>();

  UnitMasterBloc readUnitMasterBloc() => read<UnitMasterBloc>();
}
