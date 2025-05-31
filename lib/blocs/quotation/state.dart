part of 'bloc.dart';

abstract class QuotationState with ProductAndServiceStateMixin {}

class QuotationInitialState extends QuotationState {}

class QuotationLoadingState extends QuotationState {}

class QuotationDataState extends QuotationState with ManualTriggerStateMixin {
  @override
  int triggerNum = 0;
  final String docCodeGen;
  final List<Quotation> items;
  Quotation? createOrUpdateData;

  double get totalAmount {
    double result = 0;

    for (QuotationTransaction item in createOrUpdateData?.transactions ?? []) {
      result += item.qty * item.currentUnitPrice;
    }

    return result - totalDiscountPrice;
  }

  double get totalDiscountPrice {
    double result = 0;

    for (QuotationTransaction item in createOrUpdateData?.transactions ?? []) {
      result += item.discountTotal;
    }

    return result;
  }

  QuotationDataState({
    required this.docCodeGen,
    required this.items,
    this.createOrUpdateData,
  });

  QuotationDataState copyWith({
    String? docCodeGen,
    List<Quotation>? items,
    Quotation? createOrUpdateData,
  }) {
    return QuotationDataState(
      docCodeGen: docCodeGen ?? this.docCodeGen,
      items: items ?? this.items,
      createOrUpdateData: createOrUpdateData ?? this.createOrUpdateData,
    )..keepProductAndServiceItemWhenCopy(this);
  }

  QuotationDataState manualTrigger() => copyWith()..callManualTrigger(this);
}

class QuotationErrorState extends QuotationState {
  final String errorMessage;

  QuotationErrorState({required this.errorMessage});
}
