part of 'bloc.dart';

abstract class QuotationState {}

class QuotationInitialState extends QuotationState {}

class QuotationLoadingState extends QuotationState {}

class QuotationDataState extends QuotationState {
  final String docCodeGen;
  final List<Quotation> items;

  QuotationDataState({required this.docCodeGen, required this.items});

  QuotationDataState copyWith({String? docCodeGen, List<Quotation>? items}) =>
      QuotationDataState(
        docCodeGen: docCodeGen ?? this.docCodeGen,
        items: items ?? this.items,
      );
}

class QuotationErrorState extends QuotationState {
  final String errorMessage;

  QuotationErrorState({required this.errorMessage});
}
