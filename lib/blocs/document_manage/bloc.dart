import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class DocumentManageBloc
    extends Bloc<DocumentManageEvent, DocumentManageState> {
  DocumentManageBloc() : super(DocumentManageInitialState()) {
    on<DocumentManagePrintEvent>(_onPrint);
  }

  Future<void> _onPrint(
    DocumentManagePrintEvent event,
    Emitter<DocumentManageState> emit,
  ) async {
    print(event.text);
    emit(DocumentManageInitialState());
  }
}
