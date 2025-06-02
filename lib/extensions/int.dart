import 'package:accounting_module/shared/document_status_type.dart' show DocumentStatusType;

extension IntExtension on int {
  DocumentStatusType toDocumentStatus() {
    switch (this) {
      case 1:
        return DocumentStatusType.draft;
      case 2:
        return DocumentStatusType.waitInternelApprove;
      case 3:
        return DocumentStatusType.waitInternelApprove;
      case 4:
        return DocumentStatusType.internalApprove;
      case 5:
        return DocumentStatusType.internalReject;
      case 6:
        return DocumentStatusType.waitCustomerAccept;
      case 7:
        return DocumentStatusType.customerAccept;
      case 8:
        return DocumentStatusType.customerReject;
      case 9:
        return DocumentStatusType.temporaryRemove;
      default:
        return DocumentStatusType.unknown;
    }
  }
}
