
part of 'bloc.dart';

abstract class UnitMasterState {}

class UnitMasterInitialState extends UnitMasterState {}

class UnitMasterLoadingState extends UnitMasterState {}

class UnitMasterDataState extends UnitMasterState {
  final List<UnitMasterData> items;

  UnitMasterDataState({required this.items});
}
