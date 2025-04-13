import 'package:flutter/material.dart';
import 'package:accounting_module/core/global_keepings.dart';

class Dialogutil {
  static showAlertDiaglog(String title, String text) {
    showDialog(
      context: GlobalKeepings.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  static showConfirmDialog({
    required String title,
    required String text,
    required Function onConfirm,
    required Function onCancel,
  }) {
    showDialog(
      context: GlobalKeepings.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: Text('ตกลง'),
            ),
            TextButton(
              onPressed: () {
                onCancel();
                Navigator.of(context).pop();
              },
              child: Text('ยกเลิก'),
            ),
          ],
        );
      },
    );
  }
}
