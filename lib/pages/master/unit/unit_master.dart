import 'package:accounting_module/blocs/unit_master/bloc.dart';
import 'package:accounting_module/constants.dart';
import 'package:accounting_module/core/global_keepings.dart';
import 'package:accounting_module/extensions/build_context.dart';
import 'package:accounting_module/extensions/unit_master.dart';
import 'package:accounting_module/models/unit_master.dart';
import 'package:accounting_module/shared/widgets/common_scaffold.dart';
import 'package:accounting_module/shared/widgets/icon_buttons.dart';
import 'package:accounting_module/utils/dialog_util.dart';
import 'package:accounting_module/utils/media_query.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class UnitMasterPage extends StatelessWidget {
  final TextEditingController _unitCodeTextFieldController =
      TextEditingController();
  final FocusNode _unitCodeFocusNode = FocusNode();
  final TextEditingController _unitNameTextFieldController =
      TextEditingController();
  final FocusNode _unitNameFocusNode = FocusNode();
  final TextEditingController _unitNameEnTextFieldController =
      TextEditingController();
  final FocusNode _unitNameEnFocusNode = FocusNode();
  final List<String> _tableCols = [
    'รหัสหน่วย',
    'ชื่อภาษาไทย',
    'ชื่อภาษาอังกฤษ',
    'ประเภท',
    '',
  ];
  final Map<String, int> addTypeDropdownItemMap = {'สินค้า': 1, 'บริการ': 2};
  int _addTypeValue = 0;

  UnitMasterPage({super.key});

  Widget _buildAddDialogContent(BuildContext context) => SizedBox(
    width: 350,
    height: 350,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ประเภท', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
            ),
            items:
                addTypeDropdownItemMap.entries
                    .map(
                      (item) => DropdownMenuItem(
                        value: item.value,
                        child: Text(item.key),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              _addTypeValue = value ?? 0;
            },
          ),
          SizedBox(height: 16),
          Text('รหัสหน่วย', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
            ),
            controller: _unitCodeTextFieldController,
            focusNode: _unitCodeFocusNode,
            onSubmitted: (value) {},
          ),
          SizedBox(height: 16),
          Text(
            'ชื่อหน่วยภาษาไทย',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
            ),
            controller: _unitNameTextFieldController,
            focusNode: _unitNameFocusNode,
            onSubmitted: (value) {},
          ),
          SizedBox(height: 16),
          Text(
            'ชื่อหน่วยภาษาอังกฤษ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFdadbe6)),
              ),
            ),
            controller: _unitNameEnTextFieldController,
            focusNode: _unitNameEnFocusNode,
          ),
        ],
      ),
    ),
  );

  _showAddDialog(BuildContext context) {
    _unitCodeTextFieldController.text = '';
    _unitNameTextFieldController.text = '';
    _unitNameEnTextFieldController.text = '';

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'เพิ่มหน่วยใหม่',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: _buildAddDialogContent(context),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ยกเลิก'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.readUnitMasterBloc().add(
                    UnitMasterCreateEvent(
                      unitCode: _unitCodeTextFieldController.text,
                      type: _addTypeValue,
                      unitName: _unitNameTextFieldController.text,
                      unitNameEn: _unitNameEnTextFieldController.text,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text('บันทึก', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.readUnitMasterBloc().add(UnitMasterGetDataEvent());

    return CommonScaffold(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'หน่วย',
                  style: TextStyle(
                    color: Color(0XFF3b3c66),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _showAddDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        icon: Icon(Icons.add, color: Colors.white),
                        label: Text(
                          'เพิ่มหน่วยใหม่',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            BlocBuilder<UnitMasterBloc, UnitMasterState>(
              builder: (context, state) {
                if (state is UnitMasterDataState) {
                  return Expanded(
                    child: PaginatedDataTable2(
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
                                  label: Text(
                                    col,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                      source: UnitMasterDataSource(items: state.items),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: MediaQueryUtil.getScreenHeightPercent(70),
                  );
                }
              },
            ),
            // SizedBox(height: MediaQueryUtil.getScreenHeightPercent(5)),
          ],
        ),
      ),
    );
  }
}

class UnitMasterDataSource extends DataTableSource {
  final List<UnitMasterData> items;

  UnitMasterDataSource({required this.items});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      color: WidgetStateColor.resolveWith((_) => Colors.white),
      cells: [
        DataCell(Text(items[index].unitCode)),
        DataCell(Text(items[index].unitName)),
        DataCell(Text(items[index].unitNameEn)),
        DataCell(Text(items[index].unitTypeLabel)),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // EditIconButton(onPressed: () {}),
              // SizedBox(width: 16),
              DeleteIconButton(
                onPressed: () {
                  Dialogutil.showConfirmDialog(
                    title: 'ยืนยันการดำเนินการ',
                    text:
                        'คุณต้องการลบหน่วย "${items[index].unitName}" ใช่หรือไม่',
                    onConfirm: () {
                      GlobalKeepings.context.readUnitMasterBloc().add(
                        UnitMasterDeleteEvent(unitCode: items[index].unitCode),
                      );
                    },
                    onCancel: () {},
                  );
                },
              ),
            ],
          ),
        ),
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
