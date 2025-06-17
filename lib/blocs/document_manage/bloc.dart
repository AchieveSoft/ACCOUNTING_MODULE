import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class DocumentManageBloc
    extends Bloc<DocumentManageEvent, DocumentManageState> {
  DocumentManageBloc() : super(DocumentManageInitialState());
}
