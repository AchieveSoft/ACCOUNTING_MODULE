import 'package:accounting_module/blocs/quotation/bloc.dart';

extension QuotationBlocExtension on QuotationBloc {
  QuotationDataState? getCurrentDataState() =>
      state is QuotationDataState ? state as QuotationDataState : null;
}
