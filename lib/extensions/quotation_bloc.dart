import 'package:accounting_module/blocs/quotation/bloc.dart';

extension QuotationBlocExtension on QuotationBloc {
  QuotationDataState? getCurrentDataState() {
    if (state is QuotationDataState) {
      return state as QuotationDataState;
    }

    return null;
  }
}
