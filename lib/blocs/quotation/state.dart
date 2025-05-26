part of 'bloc.dart';

abstract class QuotationState {}

class QuotationInitialState extends QuotationState {}

class QuotationLoadingState extends QuotationState {}

class QuotationDataState extends QuotationState {
  final String docCodeGen;
  final List<Quotation> items;
  Quotation? createOrUpdateData;

  double get totalAmount {
    double result = 0;

    for (QuotationTransaction item in createOrUpdateData?.transactions ?? []) {
      result += (double.tryParse(item.qty) ?? 0) * item.currentUnitPrice;
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
    );
  }
}

class QuotationErrorState extends QuotationState {
  final String errorMessage;

  QuotationErrorState({required this.errorMessage});
}
