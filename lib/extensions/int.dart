import 'package:accounting_module/shared/document_status_type.dart'
    show DocumentStatusType;

extension IntExtension on int {
  DocumentStatusType toDocumentStatus() {
    switch (this) {
      case 1:
        return DocumentStatusType.draft;
      case 2:
        return DocumentStatusType.waitInternalApprove;
      case 3:
        return DocumentStatusType.internalApprove;
      case 4:
        return DocumentStatusType.internalReject;
      case 5:
        return DocumentStatusType.waitCustomerAccept;
      case 6:
        return DocumentStatusType.customerAccept;
      case 7:
        return DocumentStatusType.customerReject;
      case 8:
        return DocumentStatusType.temporaryRemove;
      case 9:
        return DocumentStatusType.expire;
      default:
        return DocumentStatusType.unknown;
    }
  }

  bool isDocumentDraftStatus() => this == 1;

  bool isDocumentWaitInternalApproveStatus() => this == 2;

  bool isDocumentInternalApproveStatus() => this == 3;

  bool isDocumentInternalRejectStatus() => this == 4;

  bool isDocumentWaitCustomerAcceptStatus() => this == 5;

  bool isDocumentCustomerAcceptStatus() => this == 6;

  bool isDocumentCustomerRejectStatus() => this == 7;

  bool isDocumentCustomerTemporaryRemoveStatus() => this == 8;

  bool isDocumentExpireStatus() => this == 9;
}
