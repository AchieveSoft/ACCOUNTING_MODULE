import 'package:accounting_module/models/accounting_category.dart';
import 'package:accounting_module/models/chat_of_account.dart';

List<AccountingCategory> mockAccountingCategories = [
  AccountingCategory(
    referenceCode: "AC001",
    name: "สินทรัพย์ (1)",
    chartOfAccountings: [
      ChartOfAccount(
        referenceCode: "111101",
        name: "เงินสด",
        description: "บัญชีเงินสด",
        children: [
          ChartOfAccount(
            referenceCode: "111111",
            name: "Test",
            description: "บัญชีเงินสด",
            children: [
              ChartOfAccount(
                referenceCode: "111111",
                name: "Test",
                description: "บัญชีเงินสด",
                children: [],
              ),
            ],
          ),
        ],
      ),
      ChartOfAccount(
        referenceCode: "111201",
        name: "ธนาคาร - บัญชีกระแสรายวัน",
        description: "บัญชีธนาคารประเภทกระแสรายวัน",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "111301",
        name: "ธนาคาร - บัญชีออมทรัพย์",
        description: "บัญชีธนาคารประเภทออมทรัพย์",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "111401",
        name: "เช็ครับที่ครบกำหนดแต่ยังมิได้ฝาก",
        description: "เช็ครับครบกำหนดที่ยังไม่ได้ฝากเข้าบัญชี",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "111501",
        name: "กระเป๋าเงินอิเล็กทรอนิกส์",
        description: "บัญชีกระเป๋าเงินอิเล็กทรอนิกส์",
        children: [],
      ),
    ],
  ),
  AccountingCategory(
    referenceCode: "AC002",
    name: "หนี้สิน (2)",
    chartOfAccountings: [
      ChartOfAccount(
        referenceCode: "112101",
        name: "ธนาคาร - ฝากประจำ",
        description: "บัญชีเงินฝากประจำ",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "112201",
        name: "เงินลงทุนชั่วคราวอื่น",
        description: "เงินลงทุนที่มีระยะเวลาสั้น",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "112202",
        name: "ทดสอบผัง 1",
        description: "บัญชีทดสอบ",
        children: [],
      ),
    ],
  ),
  AccountingCategory(
    referenceCode: "AC003",
    name: "ส่วนของเจ้าของ (3)",
    chartOfAccountings: [
      ChartOfAccount(
        referenceCode: "113101",
        name: "ลูกหนี้การค้า",
        description: "บัญชีลูกหนี้การค้า",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "113102",
        name: "เช็ครับลงวันที่ล่วงหน้า",
        description: "เช็ครับลงวันที่ล่วงหน้า",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "113103",
        name: "ค่าเผื่อหนี้สงสัยจะสูญ",
        description: "ค่าเผื่อหนี้สงสัยจะสูญ",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "113201",
        name: "เงินให้กู้ยืม-บุคคลที่เกี่ยวข้องกัน",
        description: "เงินให้กู้ยืมสำหรับบุคคลที่เกี่ยวข้องกัน",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "113202",
        name: "เงินให้กู้ยืม-บุคคลอื่น",
        description: "เงินให้กู้ยืมสำหรับบุคคลอื่น",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "113203",
        name: "เงินรับล่วงหน้าที่พนักงาน",
        description: "เงินรับล่วงหน้าที่พนักงาน",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "113301",
        name: "ลูกหนี้อื่น",
        description: "ลูกหนี้อื่น",
        children: [],
      ),
    ],
  ),
  AccountingCategory(
    referenceCode: "AC004",
    name: "รายได้ (4)",
    chartOfAccountings: [
      ChartOfAccount(
        referenceCode: "114101",
        name: "วัตถุดิบคงเหลือ",
        description: "บัญชีวัตถุดิบคงเหลือ",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "114102",
        name: "สินค้าสำเร็จรูป",
        description: "บัญชีสินค้าสำเร็จรูป",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "114103",
        name: "งานระหว่างทำ",
        description: "บัญชีงานระหว่างทำ",
        children: [],
      ),
    ],
  ),
  AccountingCategory(
    referenceCode: "AC005",
    name: "ค่าใช้จ่าย (5)",
    chartOfAccountings: [
      ChartOfAccount(
        referenceCode: "115101",
        name: "ค่าใช้จ่ายจ่ายล่วงหน้า - ค่าสินค้า",
        description: "ค่าใช้จ่ายจ่ายล่วงหน้า - ค่าสินค้า",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115102",
        name: "ค่าใช้จ่ายจ่ายล่วงหน้า - ค่าเช่า",
        description: "ค่าใช้จ่ายจ่ายล่วงหน้า - ค่าเช่า",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115103",
        name: "ค่าใช้จ่ายจ่ายล่วงหน้า - อื่น",
        description: "ค่าใช้จ่ายจ่ายล่วงหน้า - อื่น",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115104",
        name: "เงินจ่ายล่วงหน้า - เงินมัดจำ",
        description: "เงินจ่ายล่วงหน้า - เงินมัดจำ",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115105",
        name: "เงินจ่ายล่วงหน้า - เงินประกัน",
        description: "เงินจ่ายล่วงหน้า - เงินประกัน",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115201",
        name: "เงินทดรองจ่ายพนักงาน",
        description: "เงินทดรองจ่ายพนักงาน",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115301",
        name: "ดอกเบี้ยค้างรับ",
        description: "ดอกเบี้ยค้างรับ",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115302",
        name: "รายได้ค้างรับอื่น",
        description: "รายได้ค้างรับอื่น",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115401",
        name: "ภาษีซื้อ",
        description: "ภาษีซื้อ",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115402",
        name: "ภาษีซื้อยังไม่ถึงกำหนด",
        description: "ภาษีซื้อยังไม่ถึงกำหนด",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115403",
        name: "ภาษีถูกหัก ณ ที่จ่าย",
        description: "ภาษีถูกหัก ณ ที่จ่าย",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115404",
        name: "ภาษีเงินได้ครึ่งปี",
        description: "ภาษีเงินได้ครึ่งปี",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115405",
        name: "ลูกหนี้สรรพากร",
        description: "ลูกหนี้สรรพากร",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115451",
        name: "เครดิต ภ.พ.30 ที่ชำระเกินรอนำไปใช้",
        description: "เครดิต ภ.พ.30 ที่ชำระเกินรอนำไปใช้",
        children: [],
      ),
      ChartOfAccount(
        referenceCode: "115452",
        name: "ลูกหนี้สรรพากร ภ.พ.30 รอรับคืนจากการขอคืน",
        description: "ลูกหนี้สรรพากร ภ.พ.30 รอรับคืนจากการขอคืน",
        children: [],
      ),
    ],
  ),
];
