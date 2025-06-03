import 'package:accounting_module/blocs/quotation/bloc.dart';
import 'package:accounting_module/configs/routes.dart';
import 'package:accounting_module/constants.dart';
import 'package:accounting_module/extensions/build_context.dart';
import 'package:accounting_module/extensions/datetime.dart';
import 'package:accounting_module/extensions/int.dart';
import 'package:accounting_module/extensions/number_extension.dart';
import 'package:accounting_module/extensions/quotation_bloc.dart';
import 'package:accounting_module/models/quotation.dart';
import 'package:accounting_module/shared/widgets/common_list_tab.dart';
import 'package:accounting_module/shared/widgets/common_scaffold.dart';
import 'package:accounting_module/shared/widgets/document_status.dart';
import 'package:accounting_module/shared/widgets/input_decoration.dart';
import 'package:accounting_module/shared/widgets/texts.dart';
import 'package:accounting_module/utils/media_query.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuotationListPage extends StatefulWidget {
  const QuotationListPage({super.key});

  @override
  State<QuotationListPage> createState() => _QuotationListPageState();
}

class _QuotationListPageState extends State<QuotationListPage> {
  final List<String> _tableCols = [
    'เลขที่เอกสาร',
    'ลูกค้า',
    'วันที่ออก',
    'ใช้ได้ถึง',
    'มูลค่าสุทธิ',
    'สถานะ',
  ];
  final List<CommonListTotalItem> tabTotalItems = [];
  final List<CommonListTabItem> tabItems = [
    CommonListTabItem(text: 'ทั้งหมด', onTap: () {}),
    CommonListTabItem(text: 'ร่าง', onTap: () {}),
    CommonListTabItem(text: 'รออนุมัติ', onTap: () {}),
    CommonListTabItem(text: 'รอตอบกลับ', onTap: () {}),
    CommonListTabItem(text: 'พ้นกำหนด', onTap: () {}),
    CommonListTabItem(text: 'ยอมรับแล้ว', onTap: () {}),
    CommonListTabItem(text: 'ปฏิเสธแล้ว', onTap: () {}),
  ];

  @override
  void initState() {
    super.initState();
    _fetchData(context);
  }

  void _fetchData(BuildContext context) => context.readQuotationBloc().add(
    QuotationGetItemEvent(
      currentState: context.readQuotationBloc().getCurrentDataState(),
    ),
  );

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

  void _genTabTotalItems(List<Quotation> items) {
    tabTotalItems.clear();

    List<int> totalValueList = [
      items.length,
      items.where((item) => item.docStatus.isDocumentDraftStatus()).length,
      items
          .where((item) => item.docStatus.isDocumentWaitInternalApproveStatus())
          .length,
      items
          .where((item) => item.docStatus.isDocumentWaitCustomerAcceptStatus())
          .length,
      items.where((item) => item.docStatus.isDocumentExpireStatus()).length,
      items
          .where((item) => item.docStatus.isDocumentCustomerAcceptStatus())
          .length,
      items
          .where((item) => item.docStatus.isDocumentCustomerRejectStatus())
          .length,
    ];
    List<Color> totalColorList = [
      Constants.primaryColor1,
      Colors.grey,
      Colors.blueAccent,
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.redAccent,
    ];

    int loopLength = totalValueList.length - 1;

    for (int index = 0; index <= loopLength; index++) {
      tabTotalItems.add(
        CommonListTotalItem(
          value: totalValueList[index],
          color: totalColorList[index],
        ),
      );
    }
  }

  Widget _buildBody(
    BuildContext context,
  ) => BlocBuilder<QuotationBloc, QuotationState>(
    builder: (context, state) {
      if (state is QuotationDataState) {
        _genTabTotalItems(state.items);

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
              CommonListTab(items: tabItems, totalItems: tabTotalItems),
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
                      controller:
                          TextEditingController()
                            ..text =
                                state.filterValue?.startDate?.toYYYYMMDD() ??
                                '',
                      onTap: () {
                        final DateTime now = DateTime.now();
                        showDatePicker(
                          context: context,
                          firstDate: DateTime(now.year - 3),
                          lastDate: DateTime(now.year + 30),
                        ).then((value) {
                          if (value != null) {
                            // ignore: use_build_context_synchronously
                            context.readQuotationBloc().add(
                              QuotationFilterEvent(
                                currentState:
                                    // ignore: use_build_context_synchronously
                                    context
                                        .readQuotationBloc()
                                        .getCurrentDataState(),
                                startDate: value,
                              ),
                            );
                          }
                        });
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
                      controller:
                          TextEditingController()
                            ..text =
                                state.filterValue?.endDate?.toYYYYMMDD() ?? '',
                      onTap: () {
                        final DateTime now = DateTime.now();

                        showDatePicker(
                          context: context,
                          firstDate: now,
                          lastDate: DateTime(now.year + 30),
                        ).then((value) {
                          if (value != null) {
                            // ignore: use_build_context_synchronously
                            context.readQuotationBloc().add(
                              QuotationFilterEvent(
                                currentState:
                                    // ignore: use_build_context_synchronously
                                    context
                                        .readQuotationBloc()
                                        .getCurrentDataState(),
                                endDate: value,
                              ),
                            );
                          }
                        });
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
                      onSubmitted: (value) {
                        context.readQuotationBloc().add(
                          QuotationFilterEvent(
                            currentState:
                                context
                                    .readQuotationBloc()
                                    .getCurrentDataState(),
                            docNo: value,
                          ),
                        );
                      },
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
        DataCell(Text(data.effectiveDate)),
        DataCell(Text(data.expireDate)),
        DataCell(Text(data.total.toInt().fmt())),
        DataCell(DocumentStatus(status: data.docStatus.toDocumentStatus())),
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
