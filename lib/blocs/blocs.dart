import 'package:accounting_module/blocs/chart_of_account/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart' show SingleChildWidget;

class AllBlocs {
  static List<SingleChildWidget> items = [
    BlocProvider(create: (context) => ChartOfAccountBloc()),
  ];
}
