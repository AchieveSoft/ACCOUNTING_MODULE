part of 'bloc.dart';

abstract class UnitMasterEvent {}

class UnitMasterGetDataEvent extends UnitMasterEvent {}

class UnitMasterCreateOrUpdateEvent extends UnitMasterEvent {
  final bool isEdit;
  final String unitCode;
  final int type;
  final String unitName;
  final String unitNameEn;

  UnitMasterCreateOrUpdateEvent({required this.isEdit, required this.unitCode, required this.type, required this.unitName, required this.unitNameEn});
}

class UnitMasterDeleteEvent extends UnitMasterEvent {
  final String unitCode;

  UnitMasterDeleteEvent({required this.unitCode});
}
