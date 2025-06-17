import 'package:accounting_module/extensions/build_context.dart';
import 'package:accounting_module/extensions/document_manage_bloc.dart';
import 'package:accounting_module/shared/widgets/common_scaffold.dart';
import 'package:flutter/material.dart';

class PocPage extends StatelessWidget {
  const PocPage({super.key});

  @override
  Widget build(BuildContext context) => CommonScaffold(
    child: Row(
      children: [
        ElevatedButton(onPressed: () {
          context.readPoc1Bloc().callPrint('test 1');
        }, child: Text('Call POC Bloc 1')),
        ElevatedButton(onPressed: () {
          context.readPoc1Bloc().callPrint('test 2');
        }, child: Text('Call POC Bloc 2')),
        ElevatedButton(onPressed: () {
          context.readPoc1Bloc().callPrint('test 3');
        }, child: Text('Call POC Bloc 3')),
      ],
    ),
  );
}
