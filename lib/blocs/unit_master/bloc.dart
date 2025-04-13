import 'package:accounting_module/models/requests/unit_master.dart';
import 'package:accounting_module/models/responses/base_response.dart';
import 'package:accounting_module/models/unit_master.dart';
import 'package:accounting_module/services/unit_master.dart';
import 'package:accounting_module/utils/dialog_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class UnitMasterBloc extends Bloc<UnitMasterEvent, UnitMasterState> {
  UnitMasterBloc() : super(UnitMasterInitialState()) {
    on<UnitMasterGetDataEvent>(_onGetData);
    on<UnitMasterCreateEvent>(_onCreateUnit);
    on<UnitMasterDeleteEvent>(_onDeleteUnit);
  }

  Future<void> _getData(Emitter<UnitMasterState> emit) async {
    emit(UnitMasterLoadingState());
    final items = await UnitMasterService.getData();
    emit(UnitMasterDataState(items: items));
  }

  Future<void> _onGetData(
    UnitMasterGetDataEvent event,
    Emitter<UnitMasterState> emit,
  ) async {
    await _getData(emit);
  }

  Future<void> _onCreateUnit(
    UnitMasterCreateEvent event,
    Emitter<UnitMasterState> emit,
  ) async {
    final BaseResponse response = await UnitMasterService.createUnit(
      UnitMasterRequest(
        unitCode: event.unitCode,
        unitName: event.unitName,
        unitNameEn: event.unitNameEn,
        unitType: event.type,
      ),
    );

    if (response.success) {
      Dialogutil.showAlertDiaglog('ดำเนินการสำเร็จ', 'เพิ่มหน่วยสำเร็จ');
      await _getData(emit);
    } else {
      Dialogutil.showAlertDiaglog('ดำเนินการไม่สำเร็จ', response.message);
    }
  }

  Future<void> _onDeleteUnit(
    UnitMasterDeleteEvent event,
    Emitter<UnitMasterState> emit,
  ) async {
    final BaseResponse response = await UnitMasterService.deleteUnit(event.unitCode);

    if (response.success) {
      Dialogutil.showAlertDiaglog('ดำเนินการสำเร็จ', 'ลบหน่วยสำเร็จ');
      await _getData(emit);
    } else {
      Dialogutil.showAlertDiaglog('ดำเนินการไม่สำเร็จ', response.message);
    }
  }
}
