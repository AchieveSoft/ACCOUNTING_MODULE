import 'package:accounting_module/blocs/chart_of_account/bloc.dart';
import 'package:accounting_module/core/global_keys.dart';
import 'package:accounting_module/extensions/build_context.dart';
import 'package:accounting_module/models/accounting_category.dart';
import 'package:accounting_module/models/chat_of_account.dart';
import 'package:accounting_module/services/chart_of_account.dart';
import 'package:accounting_module/shared/widgets/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//[Nil] Popup เละเดี๋ยวมาแก้ ง่วงแล้ว
// ignore: unused_element
class _AddNewAccountPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartOfAccountBloc, ChartOfAccountState>(
      builder:
          (context, state) =>
              state is ChartOfAccountDataState
                  ? AlertDialog(
                    title: Text(
                      'เพิ่มบัญชีใหม่',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: SizedBox(
                      width: 500,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'ผังบัญชีหลัก',
                              ),
                              items:
                                  state.allItems
                                      .where(
                                        (item) =>
                                            item.parentCode?.isEmpty == true,
                                      )
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.referenceCode,
                                          child: Text(e.name),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                var currentSate =
                                    context.readChartOfAccountBloc().state
                                        as ChartOfAccountDataState;
                                var createData = currentSate.createData ?? {};
                                createData['mainAccountCode'] = value;
                                context.readChartOfAccountBloc().add(
                                  ChartOfAccountUpdateDataEvent(
                                    newData: currentSate.copyWith(
                                      createData: createData,
                                    ),
                                  ),
                                );
                              },
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'ผังบัญชีรอง',
                              ),
                              items:
                                  state.allItems
                                      .where(
                                        (item) =>
                                            item.parentCode ==
                                            state
                                                .createData?['mainAccountCode'],
                                      )
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.referenceCode,
                                          child: Text(e.name),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                var currentSate =
                                    context.readChartOfAccountBloc().state
                                        as ChartOfAccountDataState;
                                var createData = currentSate.createData ?? {};
                                createData['parentAccountCode'] = value;
                                context.readChartOfAccountBloc().add(
                                  ChartOfAccountUpdateDataEvent(
                                    newData: currentSate.copyWith(
                                      createData: createData,
                                    ),
                                  ),
                                );
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'เลขบัญชี',
                              ),
                              initialValue: '',
                              onChanged: (value) {
                                var currentSate =
                                    context.readChartOfAccountBloc().state
                                        as ChartOfAccountDataState;
                                var createData = currentSate.createData ?? {};
                                createData['accountCode'] = value;
                                context.readChartOfAccountBloc().add(
                                  ChartOfAccountUpdateDataEvent(
                                    newData: currentSate.copyWith(
                                      createData: createData,
                                    ),
                                  ),
                                );
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'ชื่อบัญชีภาษาไทย',
                              ),
                              onChanged: (value) {
                                var currentSate =
                                    context.readChartOfAccountBloc().state
                                        as ChartOfAccountDataState;
                                var createData = currentSate.createData ?? {};
                                createData['accountName'] = value;
                                context.readChartOfAccountBloc().add(
                                  ChartOfAccountUpdateDataEvent(
                                    newData: currentSate.copyWith(
                                      createData: createData,
                                    ),
                                  ),
                                );
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'ชื่อบัญชีภาษาอังกฤษ',
                              ),
                              onChanged: (value) {
                                var currentSate =
                                    context.readChartOfAccountBloc().state
                                        as ChartOfAccountDataState;
                                var createData = currentSate.createData ?? {};
                                createData['accountNameEn'] = value;
                                context.readChartOfAccountBloc().add(
                                  ChartOfAccountUpdateDataEvent(
                                    newData: currentSate.copyWith(
                                      createData: createData,
                                    ),
                                  ),
                                );
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'คำอธิบายบัญชี',
                              ),
                              onChanged: (value) {
                                var currentSate =
                                    context.readChartOfAccountBloc().state
                                        as ChartOfAccountDataState;
                                var createData = currentSate.createData ?? {};
                                createData['description'] = value;
                                createData['descriptionEn'] = value;
                                context.readChartOfAccountBloc().add(
                                  ChartOfAccountUpdateDataEvent(
                                    newData: currentSate.copyWith(
                                      createData: createData,
                                    ),
                                  ),
                                );
                              },
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'ประเภทเงินได้ภาษี',
                              ),
                              items:
                                  ['ไม่ระบุ']
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {},
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'อัตราภาษีหัก ณ ที่จ่าย',
                              ),
                              items:
                                  ['อัตโนมัติ']
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('ยกเลิก'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // var currentSate =
                          //     context.readChartOfAccountBloc().state
                          //         as ChartOfAccountDataState;
                          // var createData = currentSate.createData ?? {};
                          // createData['chartOfAccountLevelCode'] = '313f4765-80f4-43fa-b1da-b5746cf81ede';
                          // createData['accountingCategoryCode'] = '313f4765-80f4-43fa-b1da-b5746cf81ede';
                          // context.readChartOfAccountBloc().add(
                          //   ChartOfAccountUpdateDataEvent(
                          //     newData: currentSate.copyWith(
                          //       createData: createData,
                          //     ),
                          //   ),
                          // );
                          // ChartOfAccountService.create(
                          //   (context.readChartOfAccountBloc().state
                          //               as ChartOfAccountDataState)
                          //           .createData ??
                          //       {},
                          // ).then(
                          //   // ignore: use_build_context_synchronously
                          //   (value) => context.readChartOfAccountBloc().add(
                          //     ChartOfAccountGetDataEvent(),
                          //   ),
                          // );
                        },
                        child: Text('เพิ่มบัญชี'),
                      ),
                    ],
                  )
                  : SizedBox.shrink(),
    );
  }
}

class ChartOfAccountPage extends StatelessWidget {
  const ChartOfAccountPage({super.key});

  Widget _buildChartOfAccountTile(
    ChartOfAccount data, {
    bool isSmalText = false,
  }) => ListTile(
    minTileHeight: 50,
    title: Text(data.name, style: isSmalText ? TextStyle(fontSize: 14) : null),
    onTap: () {
      ChartOfAccountDataState currentState =
          GlobalKeepings.context.readChartOfAccountBloc().state
              as ChartOfAccountDataState;
      GlobalKeepings.context.readChartOfAccountBloc().add(
        ChartOfAccountSelectItemEvent(
          currentState: currentState,
          referenceCode: data.referenceCode,
        ),
      );
    },
  );

  Widget _buildChartOfAccountItem(ChartOfAccount data) => ExpansionTile(
    title: Text(data.name),
    children:
        data.children.map((child) {
          return Padding(
            padding: EdgeInsets.all(8),
            child:
                child.children.isNotEmpty
                    ? ExpansionTile(
                      title: Text(child.name),
                      children:
                          child.children.map((subChild) {
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: _buildChartOfAccountTile(subChild),
                            );
                          }).toList(),
                    )
                    : _buildChartOfAccountTile(child),
          );
        }).toList(),
  );

  Widget _buildAccountingCategory(AccountingCategory categoryData) => Padding(
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryData.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                categoryData.chartOfAccountings.map((chartData) {
                  return _buildChartOfAccountItem(chartData);
                }).toList(),
          ),
        ),
      ],
    ),
  );

  Widget _buildInfoText(String title, String text) => Padding(
    padding: EdgeInsets.all(8),
    child: Row(
      children: [
        SizedBox(width: 200, child: Text(title, textAlign: TextAlign.end)),
        SizedBox(width: 16),
        Text(text),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    context.readChartOfAccountBloc().add(ChartOfAccountGetDataEvent());

    return CommonScaffold(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    'ผังบัญชี',
                    style: TextStyle(
                      color: Color(0XFF3b3c66),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => _AddNewAccountPopup(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                          label: Text(
                            'เพิ่มบัญชี',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(Icons.add, color: Colors.white),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purpleAccent,
                          ),
                          label: Text(
                            'เพิ่มธนาคาร และอื่นๆ',
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
            ),
            Expanded(
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 350,
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'รายการบัญชี',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'ค้นหารายการ',
                                      suffixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0XFFdadbe6),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0XFFdadbe6),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0XFFdadbe6),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),
                                BlocBuilder<
                                  ChartOfAccountBloc,
                                  ChartOfAccountState
                                >(
                                  builder: (context, state) {
                                    if (state is ChartOfAccountDataState) {
                                      return Expanded(
                                        child: ListView.builder(
                                          itemCount: state.categoryItems.length,
                                          itemBuilder:
                                              (context, index) =>
                                                  _buildAccountingCategory(
                                                    state.categoryItems[index],
                                                  ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                ),
                                // Expanded(
                                //   child: ListView.builder(
                                //     itemCount: mockAccountingCategories.length,
                                //     itemBuilder:
                                //         (context, index) =>
                                //             _buildAccountingCategory(
                                //               mockAccountingCategories[index],
                                //             ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<ChartOfAccountBloc, ChartOfAccountState>(
                    builder: (context, state) {
                      if (state is ChartOfAccountDataState) {
                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                state
                                                        .currentItemSelect
                                                        ?.accountName ??
                                                    '-',
                                                style: TextStyle(
                                                  color: Color(0XFF3b3c66),
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                          Column(
                                            children:
                                                state.currentItemSelect != null
                                                    ? [
                                                      _buildInfoText(
                                                        'ผังบัญชีหลัก :',
                                                        state
                                                                .currentItemSelect
                                                                ?.mainAccountName ??
                                                            '-',
                                                      ),
                                                      _buildInfoText(
                                                        'ผังบัญชีรอง :',
                                                        state
                                                                .currentItemSelect
                                                                ?.subAccountName ??
                                                            '-',
                                                      ),
                                                      _buildInfoText(
                                                        'บัญชีย่อย :',
                                                        state
                                                                .currentItemSelect
                                                                ?.accountName ??
                                                            '-',
                                                      ),
                                                      _buildInfoText(
                                                        'อัตราภาษีหัก ณ ที่จ่าย :',
                                                        'อัตโนมัติ',
                                                      ),
                                                      _buildInfoText(
                                                        'ประเภทเงินได้ภาษี :',
                                                        'ไม่ระบุ',
                                                      ),
                                                      _buildInfoText(
                                                        'คำอธิบาย :',
                                                        state
                                                                .currentItemSelect
                                                                ?.accountDescription ??
                                                            '-',
                                                      ),
                                                    ]
                                                    : [],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
