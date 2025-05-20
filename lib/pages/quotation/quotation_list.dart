import 'package:accounting_module/blocs/quotation/bloc.dart';
import 'package:accounting_module/configs/routes.dart';
import 'package:accounting_module/constants.dart';
import 'package:accounting_module/extensions/build_context.dart';
import 'package:accounting_module/shared/widgets/common_scaffold.dart';
import 'package:accounting_module/shared/widgets/texts.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class QuotationListPage extends StatelessWidget {
  final List<String> _tableCols = [
    'เลขที่เอกสาร',
    'ลูกค้า',
    'วันที่ออก',
    'ใช้ได้ถึง',
    'มูลค่าสุทธิ',
    'สถานะ',
  ];

  QuotationListPage({super.key});

  void _gotoManagePage(BuildContext context) =>
      Navigator.of(context).pushNamed(RoutePaths.quotationManage);

  Widget _buildBody(BuildContext context) => Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildPageHeaderText('ใบเสนอราคา'),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _gotoManagePage(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    label: Text(
                      'สร้างใบเสนอราคา',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(Icons.add, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    label: Text(
                      'พิมพ์รายงาน',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(Icons.print, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: PaginatedDataTable2(
            showCheckboxColumn: false,
            rowsPerPage: 15,
            dataRowHeight: 46,
            border: TableBorder(
              left: BorderSide(color: Color(0XFFecf0f1)),
              right: BorderSide(color: Color(0XFFecf0f1)),
              top: BorderSide(color: Color(0XFFecf0f1)),
              bottom: BorderSide(color: Color(0XFFecf0f1)),
            ),
            headingRowColor: WidgetStateColor.resolveWith(
              (_) => Constants.primaryColor1,
            ),
            headingRowDecoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            dividerThickness: 0,
            columns:
                _tableCols
                    .map(
                      (col) => DataColumn2(
                        label: Text(col, style: TextStyle(color: Colors.white)),
                      ),
                    )
                    .toList(),
            source: QuotationDataTableSource(
              onSelectRow: () => _gotoManagePage(context),
            ),
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    context.readQuotationBloc().add(QuotationGetItemEvent());
    return CommonScaffold(child: _buildBody(context));
  }
}

class QuotationDataTableSource extends DataTableSource {
  final Function onSelectRow;

  QuotationDataTableSource({required this.onSelectRow});

  @override
  DataRow getRow(int index) => DataRow(
    onSelectChanged: (selected) {
      if (selected == true) {
        onSelectRow();
      }
    },
    cells: [
      DataCell(Text('QO-00$index')),
      DataCell(Text('ลูกค้าตัวอย่าง')),
      DataCell(Text('2030-01-01')),
      DataCell(Text('2090-01-01')),
      DataCell(Text('100,000')),
      DataCell(Text('รออนุมัติ', style: TextStyle(color: Colors.amber))),
    ],
  );

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
