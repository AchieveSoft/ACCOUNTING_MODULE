part of 'bloc.dart';

abstract class DocumentManageState {}

class DocumentManageInitialState extends DocumentManageState {}

class DocumentManageLoadingState extends DocumentManageState {}

class DocumentManageDataState extends DocumentManageState {}

class DocumentManageErrorState extends DocumentManageState {
  final String errorCode;
  final String errorMessage;

  DocumentManageErrorState({
    required this.errorCode,
    required this.errorMessage,
  });
}
