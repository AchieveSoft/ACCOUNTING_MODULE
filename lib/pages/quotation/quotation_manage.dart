import 'package:accounting_module/blocs/quotation/bloc.dart';
import 'package:accounting_module/constants.dart';
import 'package:accounting_module/core/global_keepings.dart';
import 'package:accounting_module/extensions/build_context.dart';
import 'package:accounting_module/extensions/datetime.dart';
import 'package:accounting_module/extensions/number_extension.dart';
import 'package:accounting_module/extensions/quotation_bloc.dart';
import 'package:accounting_module/models/product_and_service_master.dart';
import 'package:accounting_module/models/quotation.dart';
import 'package:accounting_module/shared/widgets/common_scaffold.dart';
import 'package:accounting_module/shared/widgets/common_stepper.dart';
import 'package:accounting_module/shared/widgets/icon_buttons.dart';
import 'package:accounting_module/shared/widgets/input_decoration.dart';
import 'package:accounting_module/shared/widgets/texts.dart';
import 'package:accounting_module/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum QuotationManagePageType { create, view }

// ignore: must_be_immutable
class QuotationManagePage extends StatelessWidget {
  final QuotationManagePageType pageType;
  final TextEditingController _effectiveDateTextFieldController =
      TextEditingController();
  final TextEditingController _expireDateTextFieldController =
      TextEditingController();

  List<CommonStepperItem> mockSteps = [
    CommonStepperItem(text: 'ใบเสนอราคา', key: 'approve'),
    CommonStepperItem(text: 'รอตอบกลับ', key: 'accept'),
    CommonStepperItem(text: 'ใบแจ้งหนี้', key: 'invoice'),
    CommonStepperItem(text: 'รับชำระ', key: 'payment'),
    CommonStepperItem(text: 'ใบเสร็จรับเงิน', key: 'receipt'),
    CommonStepperItem(text: 'ออกใบกำกับภาษี', key: 'tax'),
  ];

  QuotationManagePage({super.key, required this.pageType});

  Widget _buildTransactionRow(
    QuotationTransaction data,
    List<ProductsAndServiceMaster> productAndServiceItems,
    int index,
  ) => Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 48, top: 16, bottom: 16),
        child: DataTable(
          border: TableBorder.all(
            color: Colors.grey,
            width: 1,
            borderRadius: BorderRadius.circular(8),
          ),
          columns: [
            DataColumn(
              label: SizedBox(
                width: MediaQueryUtil.getScreenWidthPercent(8),
                child: Text('สินค้า/บริการ', overflow: TextOverflow.ellipsis),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: MediaQueryUtil.getScreenWidthPercent(
                  index != 0 ? 10.9 : 8,
                ),
                child: Text('บัญชี', overflow: TextOverflow.ellipsis),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: MediaQueryUtil.getScreenWidthPercent(5),
                child: Text('จำนวน', overflow: TextOverflow.ellipsis),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: MediaQueryUtil.getScreenWidthPercent(5),
                child: Text('ราคา/หน่วย', overflow: TextOverflow.ellipsis),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: MediaQueryUtil.getScreenWidthPercent(5),
                child: Text('ส่วนลด/หน่วย', overflow: TextOverflow.ellipsis),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: MediaQueryUtil.getScreenWidthPercent(5),
                child: Text('ภาษี', overflow: TextOverflow.ellipsis),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: MediaQueryUtil.getScreenWidthPercent(5),
                child: Text('มูลค่าก่อนภาษี', overflow: TextOverflow.ellipsis),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: MediaQueryUtil.getScreenWidthPercent(5),
                child: Text('หัก ณ ที่จ่าย', overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(
                  DropdownButtonFormField(
                    decoration: inputDecorationBorderNone,
                    value: '',
                    items: [
                      DropdownMenuItem(
                        value: '',
                        child: Text('สินค้าตัวอย่าง'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
                DataCell(
                  DropdownButtonFormField(
                    decoration: inputDecorationBorderNone,
                    // value: data.productOrServiceCode,
                    // value:
                    //     pageType == QuotationManagePageType.create
                    //         ? productAndServiceItems[0].productAndServiceCode
                    //         : data.productOrServiceCode,
                    value: productAndServiceItems[0].productAndServiceCode,
                    items:
                        productAndServiceItems
                            .map(
                              (item) => DropdownMenuItem(
                                value: item.productAndServiceCode,
                                child: Text(item.name),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {},
                  ),
                ),
                DataCell(
                  TextField(
                    decoration: inputDecorationBorderNone,
                    controller:
                        TextEditingController()..text = data.qty.toString(),
                    onSubmitted: (value) {
                      GlobalKeepings.context
                          .readQuotationBloc()
                          .manualTrigger();
                      data.qty = (int.tryParse(value) ?? 0);
                    },
                  ),
                ),
                DataCell(
                  TextField(
                    decoration: inputDecorationBorderNone,
                    controller:
                        TextEditingController()
                          ..text = data.currentUnitPrice.toString(),
                    onChanged: (value) {
                      data.currentUnitPrice = double.tryParse(value) ?? 0;
                    },
                  ),
                ),
                DataCell(
                  TextField(
                    decoration: inputDecorationBorderNone,
                    controller:
                        TextEditingController()
                          ..text = data.discountTotal.toInt().fmt(),
                    onSubmitted: (value) {
                      data.discountTotal = double.tryParse(value) ?? 0;
                      GlobalKeepings.context
                          .readQuotationBloc()
                          .manualTrigger();
                    },
                  ),
                ),
                DataCell(
                  DropdownButtonFormField(
                    decoration: inputDecorationBorderNone,
                    value: 1,
                    items: [
                      DropdownMenuItem(value: 1, child: Text('7%')),
                      DropdownMenuItem(value: 2, child: Text('ไม่มี')),
                    ],
                    onChanged: (value) {
                      data.whtType = value ?? 1;
                    },
                  ),
                ),
                DataCell(Text('0.00', overflow: TextOverflow.ellipsis)),
                DataCell(Text('ยังไม่ระบุ', overflow: TextOverflow.ellipsis)),
              ],
            ),
          ],
        ),
      ),
      SizedBox(width: 16),
      index != 0
          ? SizedBox(
            width: 69,
            height: 69,
            child: DeleteIconButton(
              onPressed: () {
                GlobalKeepings.context.readQuotationBloc().add(
                  QuotationRemoveTransaction(
                    removeIndex: index,
                    currentState:
                        GlobalKeepings.context
                            .readQuotationBloc()
                            .getCurrentDataState(),
                  ),
                );
              },
            ),
          )
          : SizedBox.shrink(),
    ],
  );

  Widget _buildBody(
    BuildContext context,
  ) => BlocBuilder<QuotationBloc, QuotationState>(
    builder: (context, state) {
      if (state is QuotationDataState) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 48, right: 48, bottom: 16),
                child: CommonStepper(steps: mockSteps),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [buildPageHeaderText('สร้างใบเสนอราคา')],
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
                                BlocBuilder<QuotationBloc, QuotationState>(
                                  builder: (context, state) {
                                    if (state is QuotationDataState) {
                                      return SizedBox(
                                        width: 200,
                                        child: TextField(
                                          decoration:
                                              buildCommonInputDecoration(
                                                label: buildNormalRequiredText(
                                                  'เลขที่เอกสาร',
                                                ),
                                                isDense: true,
                                              ),
                                          controller:
                                              TextEditingController()
                                                ..text =
                                                    state
                                                        .createOrUpdateData
                                                        ?.docCode ??
                                                    '',
                                          onChanged: (value) {},
                                          readOnly: true,
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
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
                                    'รายละเอียดลูกค้า',
                                  ),
                                ),
                                SizedBox(
                                  width: 400,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DropdownButtonFormField(
                                        decoration: buildCommonInputDecoration(
                                          label: buildNormalRequiredText(
                                            'ชื่อลูกค้า',
                                          ),
                                        ),
                                        value:
                                            // state
                                            //     .createOrUpdateData
                                            //     ?.contractCode ??
                                            // '',
                                            '',
                                        items: [
                                          DropdownMenuItem(
                                            value: '',
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: TextField(
                                        decoration: buildCommonInputDecoration(
                                          label: buildNormalRequiredText(
                                            'วันที่ออก',
                                          ),
                                          isDense: true,
                                          suffixIcon: Icon(
                                            Icons.calendar_today,
                                          ),
                                        ),
                                        controller:
                                            _effectiveDateTextFieldController
                                              ..text =
                                                  state
                                                      .createOrUpdateData
                                                      ?.effectiveDate ??
                                                  '',
                                        readOnly: true,
                                        onTap: () {
                                          final DateTime now = DateTime.now();

                                          showDatePicker(
                                            context: context,
                                            firstDate: now,
                                            lastDate: DateTime(now.year + 30),
                                          ).then((value) {
                                            if (value == null) {
                                              return;
                                            }
                                            state
                                                    .createOrUpdateData!
                                                    .effectiveDate =
                                                value.toYYYYMMDD();
                                            _effectiveDateTextFieldController
                                                .text = state
                                                    .createOrUpdateData!
                                                    .effectiveDate;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    SizedBox(
                                      width: 200,
                                      child: TextField(
                                        decoration: buildCommonInputDecoration(
                                          label: buildNormalRequiredText(
                                            'วันที่ใช้ถึง',
                                          ),
                                          isDense: true,
                                          suffixIcon: Icon(
                                            Icons.calendar_today,
                                          ),
                                        ),
                                        controller:
                                            _expireDateTextFieldController
                                              ..text =
                                                  state
                                                      .createOrUpdateData
                                                      ?.expireDate ??
                                                  '',
                                        readOnly: true,
                                        onTap: () {
                                          final DateTime now = DateTime.now();

                                          showDatePicker(
                                            context: context,
                                            firstDate: now,
                                            lastDate: DateTime(now.year + 30),
                                          ).then((value) {
                                            if (value == null) {
                                              return;
                                            }
                                            state
                                                    .createOrUpdateData!
                                                    .expireDate =
                                                value.toYYYYMMDD();
                                            _expireDateTextFieldController
                                                .text = state
                                                    .createOrUpdateData!
                                                    .expireDate;
                                          });
                                        },
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
                                        child: Text('ไม่มี'),
                                      ),
                                    ],
                                    onChanged: null,
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
                                  onPressed: () {
                                    context.readQuotationBloc().add(
                                      QuotationAddTransactionEvent(
                                        currentState: state,
                                      ),
                                    );
                                  },
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
                            ...state.createOrUpdateData!.transactions.indexed
                                .map(
                                  (entry) => _buildTransactionRow(
                                    entry.$2,
                                    state.productAndServiceItems,
                                    entry.$1,
                                  ),
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
                                              ..text =
                                                  state.totalDiscountPrice
                                                      .toInt()
                                                      .fmt(),
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
                                                '${state.totalAmount.toInt().fmt()} บาท',
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
                                  onPressed: () {
                                    context.readQuotationBloc().add(
                                      QuotationCreatOrUpdateEvent(
                                        createOrUpdateData:
                                            context
                                                .readQuotationBloc()
                                                .getCurrentDataState()!
                                                .createOrUpdateData!,
                                        currentState:
                                            context
                                                .readQuotationBloc()
                                                .getCurrentDataState(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purpleAccent,
                                  ),
                                  icon: Icon(Icons.check, color: Colors.white),
                                  label: Text(
                                    'อนุมัติใบเสนอราคา',
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
        );
      } else if (state is QuotationInitialState) {
        context.readQuotationBloc().add(
          QuotationInitialCreatePageEvent(
            currentState: context.readQuotationBloc().getCurrentDataState(),
          ),
        );
        return SizedBox.shrink();
      } else {
        return SizedBox.shrink();
      }
    },
  );

  void _onPop(BuildContext context) {
    context.readQuotationBloc().add(
      QuotationGetItemEvent(
        currentState: context.readQuotationBloc().getCurrentDataState(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        _onPop(context);
      },
      child: CommonScaffold(child: _buildBody(context)),
    );
  }
}
