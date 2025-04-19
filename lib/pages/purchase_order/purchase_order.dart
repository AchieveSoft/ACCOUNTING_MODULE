import 'package:accounting_module/constants.dart';
import 'package:accounting_module/shared/widgets/common_scaffold.dart';
import 'package:accounting_module/shared/widgets/input_decoration.dart';
import 'package:accounting_module/shared/widgets/texts.dart';
import 'package:flutter/material.dart';

class PurchaseOrderPage extends StatelessWidget {
  const PurchaseOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [buildPageHeaderText('สร้างใบสั่งซื้อ')],
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildHeaderText('รายละเอียด'),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  decoration: buildCommonInputDecoration(
                                    label: buildNormalRequiredText(
                                      'เลขที่เอกสาร',
                                    ),
                                    isDense: true,
                                  ),
                                  controller:
                                      TextEditingController()
                                        ..text = 'PO-20250419001',
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                child: buildSecondaryHeaderText(
                                  'รายละเอียดผู้ขาย',
                                ),
                              ),
                              SizedBox(
                                width: 400,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownButtonFormField(
                                      decoration: buildCommonInputDecoration(
                                        label: buildNormalRequiredText(
                                          'ชื่อผู้ขาย',
                                        ),
                                      ),
                                      value: 0,
                                      items: [
                                        DropdownMenuItem(
                                          value: 0,
                                          child: Text(
                                            'ลูกค้าตัวอย่าง (สำนักงานใหญ่)',
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                    SizedBox(height: 8),
                                    buildBoldText('ที่อยู่'),
                                    Text(
                                      '999 ถนนรัชดาภิเษก, ดินแดง, ดินแดง, กรุงเทพมหานคร, 10400',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: InkWell(
                                  onTap: () {},
                                  child: TextField(
                                    decoration: buildCommonInputDecoration(
                                      label: buildNormalRequiredText(
                                        'วันที่ออก',
                                      ),
                                      isDense: true,
                                      suffixIcon: Icon(Icons.calendar_today),
                                    ),
                                    controller:
                                        TextEditingController()
                                          ..text = '20250419',
                                    readOnly: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                child: buildSecondaryHeaderText(
                                  'ข้อมูลราคาและภาษี',
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: DropdownButtonFormField(
                                  decoration: buildCommonInputDecoration(
                                    label: buildNormalRequiredText(
                                      'ประเภทราคา',
                                    ),
                                  ),
                                  value: 1,
                                  items: [
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text('แยกภาษี'),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Text('รวมภาษี'),
                                    ),
                                    DropdownMenuItem(
                                      value: 3,
                                      child: Text('ไม่มี'),
                                    ),
                                  ],
                                  onChanged: (value) {},
                                ),
                              ),
                              SizedBox(width: 400),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                child: buildSecondaryHeaderText('รายการ'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                ),
                                icon: Icon(Icons.add, color: Colors.white),
                                label: Text(
                                  'เพิ่มรายการใหม่',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          DataTable(
                            border: TableBorder.all(
                              color: Colors.grey,
                              width: 1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'สินค้า/บริการ',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'บัญชี',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'จำนวน',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'ราคา/หน่วย',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'ส่วนลด/หน่วย',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'ภาษี',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'มูลค่าก่อนภาษี',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'หัก ณ ที่จ่าย',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(
                                    DropdownButtonFormField(
                                      decoration: inputDecorationBorderNone,
                                      value: 1,
                                      items: [
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text('P00001 - สินค้า A'),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  DataCell(
                                    DropdownButtonFormField(
                                      decoration: inputDecorationBorderNone,
                                      value: 1,
                                      items: [
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text(
                                            '114102 - สินค้าสำเร็จรูป',
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  DataCell(
                                    TextField(
                                      decoration: inputDecorationBorderNone,
                                      controller:
                                          TextEditingController()..text = '1',
                                    ),
                                  ),
                                  DataCell(
                                    TextField(
                                      decoration: inputDecorationBorderNone,
                                      controller:
                                          TextEditingController()
                                            ..text = '0.00',
                                    ),
                                  ),
                                  DataCell(
                                    TextField(
                                      decoration: inputDecorationBorderNone,
                                      controller:
                                          TextEditingController()
                                            ..text = '0.00',
                                    ),
                                  ),
                                  DataCell(
                                    DropdownButtonFormField(
                                      decoration: inputDecorationBorderNone,
                                      value: 1,
                                      items: [
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text('7%'),
                                        ),
                                        DropdownMenuItem(
                                          value: 2,
                                          child: Text('ไม่มี'),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      '0.00',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      'ยังไม่ระบุ',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                child: buildSecondaryHeaderText('สรุปข้อมูล'),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: TextField(
                                      decoration: buildCommonInputDecoration(
                                        label: Text('ส่วนลดรวม (บาท)'),
                                      ),
                                      textAlign: TextAlign.end,
                                      controller:
                                          TextEditingController()
                                            ..text = '0.00',
                                    ),
                                  ),
                                  SizedBox(width: 36),
                                  SizedBox(
                                    width: 350,
                                    height: 90,
                                    child: Card(
                                      color: Constants.primaryColor1,
                                      child: Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            buildBoldText(
                                              'จำนวนทั้งสิ้น',
                                              color: Colors.white,
                                            ),
                                            buildBoldText(
                                              '0.00 บาท',
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(),
                          SizedBox(height: 16),
                          ExpansionTile(
                            tilePadding: EdgeInsets.zero,
                            expandedAlignment: Alignment.centerRight,
                            title: buildSecondaryHeaderText(
                              'หมายเหตุสำหรับผู้ขาย',
                            ),
                            children: [
                              SizedBox(height: 16),
                              SizedBox(
                                width: 700,
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 6,
                                  maxLines: null,
                                  decoration: buildCommonInputDecoration(
                                    hintText: 'หมายเหตุสำหรับผู้ขาย',
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(),
                          SizedBox(height: 16),
                          ExpansionTile(
                            tilePadding: EdgeInsets.zero,
                            expandedAlignment: Alignment.centerRight,
                            title: buildSecondaryHeaderText(
                              'แนบไฟล์ในเอกสารนี้',
                            ),
                            children: [],
                          ),
                          SizedBox(height: 16),
                          Divider(),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                ),
                                label: Text(
                                  'ยกเลิก',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 16),
                              ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                ),
                                icon: Icon(Icons.add, color: Colors.white),
                                label: Text(
                                  'บันทึกร่าง',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 16),
                              ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purpleAccent,
                                ),
                                icon: Icon(Icons.check, color: Colors.white),
                                label: Text(
                                  'อนุมัติใบสั่งซื้อ',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
