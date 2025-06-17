part of 'bloc.dart';

abstract class DocumentManageEvent {}

class DocumentManagePrintEvent extends DocumentManageEvent {
  final String text;

  DocumentManagePrintEvent(this.text);
}
