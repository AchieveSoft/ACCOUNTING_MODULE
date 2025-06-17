import 'package:accounting_module/blocs/document_manage/bloc.dart';

extension DocumentManageBlocExtension on DocumentManageBloc {
  callPrint(String text) => add(DocumentManagePrintEvent(text));
}
