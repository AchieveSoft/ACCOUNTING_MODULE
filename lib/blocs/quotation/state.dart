part of 'bloc.dart';

abstract class QuotationState {}

class QuotationInitialState extends QuotationState {}

class QuotationLoadingState extends QuotationState {}

class QuotationDataState extends QuotationState {
  final List<Quotation> items;

  QuotationDataState({required this.items});

  QuotationDataState copyWith({List<Quotation>? items}) =>
      QuotationDataState(items: items ?? this.items);
}

class QuotationErrorState extends QuotationState {
  final String errorMessage;

  QuotationErrorState({required this.errorMessage});
}
