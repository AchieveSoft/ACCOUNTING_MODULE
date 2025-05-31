import 'package:accounting_module/blocs/quotation/bloc.dart';
import 'package:accounting_module/core/global_keepings.dart';
import 'package:accounting_module/extensions/build_context.dart';

extension QuotationBlocExtension on QuotationBloc {
  QuotationDataState? getCurrentDataState() =>
      state is QuotationDataState ? state as QuotationDataState : null;

  void manualTrigger() => add(
    QuotationManualTriggerEvent(
      currentState:
          GlobalKeepings.context.readQuotationBloc().getCurrentDataState(),
    ),
  );
}

extension QuotationEventExtension on QuotationEvent {
  QuotationState getCurrentState() =>
      GlobalKeepings.context.readQuotationBloc().state;
}
