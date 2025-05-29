import 'package:accounting_module/blocs/quotation/bloc.dart';
import 'package:accounting_module/configs/routes.dart';
import 'package:accounting_module/constants.dart';
import 'package:accounting_module/extensions/build_context.dart';
import 'package:accounting_module/extensions/quotation_bloc.dart';
import 'package:accounting_module/models/quotation.dart';
import 'package:accounting_module/shared/widgets/common_list_tab.dart';
import 'package:accounting_module/shared/widgets/common_scaffold.dart';
import 'package:accounting_module/shared/widgets/input_decoration.dart';
import 'package:accounting_module/shared/widgets/texts.dart';
import 'package:accounting_module/utils/media_query.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuotationListPage extends StatelessWidget {
  final List<String> _tableCols = [
    'เลขที่เอกสาร',
    'ลูกค้า',
    'วันที่ออก',
    'ใช้ได้ถึง',
    'มูลค่าสุทธิ',
    'สถานะ',
  ];
  final List<CommonListTabItem> tabItems = [
    CommonListTabItem(text: 'ทั้งหมด', onTap: () {}),
    CommonListTabItem(text: 'ร่าง', onTap: () {}),
    CommonListTabItem(text: 'รออนุมัติ', onTap: () {}),
    CommonListTabItem(text: 'รอตอบกลับ', onTap: () {}),
    CommonListTabItem(text: 'พ้นกำหนด', onTap: () {}),
    CommonListTabItem(text: 'ยอมรับแล้ว', onTap: () {}),
    CommonListTabItem(text: 'ปฏิเสธแล้ว', onTap: () {}),
  ];

  QuotationListPage({super.key});

  void _gotoViewPage(BuildContext context, Quotation data) {
    context.readQuotationBloc().add(
      QuotationViewDetailEvent(
        data: data,
        currentState: context.readQuotationBloc().getCurrentDataState(),
      ),
    );
    Navigator.of(context).pushNamed(RoutePaths.quotationView);
  }

  void _gotoCreatePage(BuildContext context) {
    context.readQuotationBloc().add(
      QuotationInitialCreatePageEvent(
        currentState: context.readQuotationBloc().getCurrentDataState(),
      ),
    );

    Navigator.of(context).pushNamed(RoutePaths.quotationCreate);
  }

  Widget _buildBody(BuildContext context) =>
      BlocBuilder<QuotationBloc, QuotationState>(
        builder: (context, state) {
          if (state is QuotationDataState) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
                              onPressed: () => _gotoCreatePage(context),
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
                  SizedBox(height: 16),
                  CommonListTab(items: tabItems),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextField(
                          decoration: buildCommonInputDecoration(
                            label: Text('วันที่ออก (เริ่มต้น)'),
                            isDense: true,
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () {
                            final DateTime now = DateTime.now();
                            showDatePicker(
                              context: context,
                              firstDate: now,
                              lastDate: DateTime(now.year + 30),
                            ).then((value) {});
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          decoration: buildCommonInputDecoration(
                            label: Text('วันที่ออก (สิ้นสุด)'),
                            isDense: true,
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () {
                            final DateTime now = DateTime.now();

                            showDatePicker(
                              context: context,
                              firstDate: now,
                              lastDate: DateTime(now.year + 30),
                            ).then((value) {});
                          },
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          decoration: buildCommonInputDecoration(
                            labelText: 'ค้าหาชื่อ, เลขที่',
                            isDense: true,
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      TextButton(
                        onPressed: () {},
                        child: buildBoldText('ค้นหาขั้นสูง'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: PaginatedDataTable2(
                      showCheckboxColumn: false,
                      rowsPerPage: 10,
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
                                  label: Text(
                                    col,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                      source: QuotationDataTableSource(
                        items: state.items,
                        onSelectRow: (data) => _gotoViewPage(context, data),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQueryUtil.getScreenHeightPercent(25)),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    context.readQuotationBloc().add(QuotationGetItemEvent());
    return CommonScaffold(child: _buildBody(context));
  }
}

class QuotationDataTableSource extends DataTableSource {
  final List<Quotation> items;
  final Function(Quotation) onSelectRow;

  QuotationDataTableSource({required this.items, required this.onSelectRow});

  @override
  DataRow getRow(int index) {
    final Quotation data = items[index];

    return DataRow(
      onSelectChanged: (selected) {
        if (selected == true) {
          onSelectRow(items[index]);
        }
      },
      cells: [
        DataCell(Text(data.docCode)),
        DataCell(Text('ลูกค้าตัวอย่าง')),
        DataCell(Text(data.acceptDate.toString())),
        DataCell(Text(data.acceptDate.toString())),
        DataCell(Text('100,000')),
        DataCell(Text('หมดอายุ', style: TextStyle(color: Colors.redAccent))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => items.length;

  @override
  int get selectedRowCount => 0;
}
