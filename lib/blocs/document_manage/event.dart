part of 'bloc.dart';

abstract class DocumentManageEvent {}

class DocumentManageUpdateUiEvent extends DocumentManageEvent {}

class DocumentManageGetItemEvent extends DocumentManageEvent {}

class DocumentManageCreateOrUpdateEvent extends DocumentManageEvent {
  final bool isUpdate;
  final Map<String, dynamic> data;

  DocumentManageCreateOrUpdateEvent({
    required this.data,
    this.isUpdate = false,
  });
}

class DocumentManageSendEmailEvent extends DocumentManageEvent {}
