import 'package:accounting_module/blocs/chart_of_account/bloc.dart';
import 'package:accounting_module/extensions/build_context.dart';
import 'package:accounting_module/models/accounting_category.dart';
import 'package:accounting_module/models/chat_of_account.dart';
import 'package:accounting_module/shared/widgets/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartOfAccountPage extends StatelessWidget {
  const ChartOfAccountPage({super.key});

  Widget _buildChartOfAccountItem(ChartOfAccount data) => ExpansionTile(
    title: Text(data.name),
    children:
        data.children.map((child) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: ExpansionTile(
              title: Text(child.name),
              children:
                  child.children.map((subChild) {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: ListTile(
                        minTileHeight: 50,
                        title: Text(subChild.name, style: TextStyle(fontSize: 14)),
                      ),
                    );
                  }).toList(),
            ),
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
                          onPressed: () {},
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
                  Expanded(
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
                                          '111201 - ธนาคาร - บัญชีกระแสรายวัน',
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
                                      children: [
                                        _buildInfoText(
                                          'ผังบัญชีหลัก :',
                                          '11 สินทรัพย์หมุนเวียน',
                                        ),
                                        _buildInfoText(
                                          'ผังบัญชีรอง :',
                                          '1 เงินสดและรายการเทียบเท่าเงินสด',
                                        ),
                                        _buildInfoText(
                                          'ผังบัญชีย่อย :',
                                          '2 บัญชีกระแสรายวัน',
                                        ),
                                        _buildInfoText(
                                          'อัตราภาษีหัก ณ ที่จ่าย :',
                                          'อัตโนมัติ',
                                        ),
                                        _buildInfoText(
                                          'ประเภทเงินได้ภาษี :',
                                          'ไม่ระบุ',
                                        ),
                                        _buildInfoText('คำอธิบาย :', ''),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
