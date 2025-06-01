part of 'bloc.dart';

abstract class QuotationState with ProductAndServiceStateMixin {}

class QuotationInitialState extends QuotationState {}

class QuotationLoadingState extends QuotationState {}

class QuotationFilterStateValue {
  final String? docNo;
  final String? remark;
  final DateTime? startDate;
  final DateTime? endDate;

  QuotationFilterStateValue({
    this.docNo,
    this.remark,
    this.startDate,
    this.endDate,
  });

  QuotationFilterStateValue merge(QuotationFilterStateValue mergeInstance) =>
      QuotationFilterStateValue(
        docNo: mergeInstance.docNo ?? docNo,
        remark: mergeInstance.remark ?? remark,
        startDate: mergeInstance.startDate ?? startDate,
        endDate: mergeInstance.endDate ?? endDate,
      );
}

class QuotationDataState extends QuotationState with ManualTriggerStateMixin {
  @override
  int triggerNum = 0;
  final String docCodeGen;
  List<Quotation>? tempItems;
  final List<Quotation> items;
  Quotation? createOrUpdateData;
  QuotationFilterStateValue? filterValue;

  double get totalAmount {
    double result = 0;

    for (QuotationTransaction item in createOrUpdateData?.transactions ?? []) {
      result += item.currentUnitPrice * item.qty;
    }

    return result - totalDiscountPrice;
  }

  double get totalDiscountPrice {
    double result = 0;

    for (QuotationTransaction item in createOrUpdateData?.transactions ?? []) {
      result += item.discountTotal * item.qty;
    }

    return result;
  }

  QuotationDataState({
    required this.docCodeGen,
    required this.items,
    this.tempItems,
    this.createOrUpdateData,
    this.filterValue,
  });

  QuotationDataState copyWith({
    String? docCodeGen,
    List<Quotation>? items,
    Quotation? createOrUpdateData,
    QuotationFilterStateValue? filterValue,
  }) {
    return QuotationDataState(
      docCodeGen: docCodeGen ?? this.docCodeGen,
      items: items ?? this.items,
      createOrUpdateData: createOrUpdateData ?? this.createOrUpdateData,
      tempItems: tempItems,
      filterValue: filterValue ?? this.filterValue,
    )..keepProductAndServiceItemWhenCopy(this);
  }

  QuotationDataState manualTrigger() => copyWith()..callManualTrigger(this);
}

class QuotationErrorState extends QuotationState {
  final String errorMessage;

  QuotationErrorState({required this.errorMessage});
}
