import 'package:flutter/material.dart';
import 'package:accounting_module/shared/document_status_type.dart';

class DocumentStatus extends StatelessWidget {
  final DocumentStatusType status;
  final Map<DocumentStatusType, Color> _colorMapping = {
    DocumentStatusType.unknown: Colors.grey,
    DocumentStatusType.draft: Colors.grey,
    DocumentStatusType.waitInternelApprove: Colors.blueAccent,
    DocumentStatusType.internalApprove: Colors.greenAccent,
    DocumentStatusType.internalReject: Colors.redAccent,
    DocumentStatusType.waitCustomerAccept: Colors.purpleAccent,
    DocumentStatusType.customerAccept: Colors.greenAccent,
    DocumentStatusType.customerReject: Colors.redAccent,
    DocumentStatusType.temporaryRemove: Colors.orangeAccent,
  };
  final Map<DocumentStatusType, String> _messageMapping = {
    DocumentStatusType.unknown: 'ไม่รู้สถานะ',
    DocumentStatusType.draft: 'ร่าง',
    DocumentStatusType.waitInternelApprove: 'รออนุมัติ',
    DocumentStatusType.internalApprove: 'อนุมัติแล้ว',
    DocumentStatusType.internalReject: 'ปฏิเสธแล้ว',
    DocumentStatusType.waitCustomerAccept: 'รอตอบกลับ',
    DocumentStatusType.customerAccept: 'ยอมรับแล้ว',
    DocumentStatusType.customerReject: 'ปฏิเสธแล้ว',
    DocumentStatusType.temporaryRemove: 'อยู่ในถังขยะ',
  };

  Color get _color => _colorMapping[status]!;

  String get _message => _messageMapping[status]!;

  DocumentStatus({super.key, required this.status});

  Widget _buildStatusCircle() => Container(
    width: 14,
    height: 14,
    decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
  );

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [_buildStatusCircle(), SizedBox(width: 8), Text(_message)],
  );
}
