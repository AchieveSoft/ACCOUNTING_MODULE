import 'package:flutter/material.dart';
import 'package:accounting_module/core/global_keepings.dart';

class Dialogutil {
  static showAlertDiaglog(String title, String text) {
    showDialog(
      context: GlobalKeepings.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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
}
