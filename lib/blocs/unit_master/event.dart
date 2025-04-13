part of 'bloc.dart';

abstract class UnitMasterEvent {}

class UnitMasterGetDataEvent extends UnitMasterEvent {}

class UnitMasterCreateEvent extends UnitMasterEvent {
  final String unitCode;
  final int type;
  final String unitName;
  final String unitNameEn;

  UnitMasterCreateEvent({required this.unitCode, required this.type, required this.unitName, required this.unitNameEn});
}

class UnitMasterDeleteEvent extends UnitMasterEvent {
  final String unitCode;

  UnitMasterDeleteEvent({required this.unitCode});
}
