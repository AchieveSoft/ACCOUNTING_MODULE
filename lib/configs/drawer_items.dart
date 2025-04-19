import 'package:accounting_module/configs/routes.dart';
import 'package:accounting_module/core/global_keepings.dart';
import 'package:flutter/material.dart';
import 'package:accounting_module/models/drawer_item.dart';

class DrawerItemConfig {
  static List<DrawerItem> items = [
    DrawerItem(
      key: 'dashboard',
      icon: Icons.dashboard,
      title: 'แดชบอร์ด',
      menuItem: [],
    ),
    DrawerItem(
      key: 'revenue',
      icon: Icons.attach_money,
      title: 'รายรับ',
      menuItem: [
        MenuItem(title: 'ใบเสนอราคา', onTap: () {}),
        MenuItem(title: 'ใบแจ้งหนี้', onTap: () {}),
        MenuItem(title: 'ใบเสร็จรับเงิน', onTap: () {}),
      ],
    ),
    DrawerItem(
      key: 'expenses',
      icon: Icons.book_online,
      title: 'รายจ่าย',
      menuItem: [
        MenuItem(
          title: 'ใบสั่งซิ้อ',
          onTap:
              () => Navigator.of(
                GlobalKeepings.context,
              ).pushNamed(RoutePaths.purchaseOrder),
        ),
        MenuItem(title: 'ใบจ่ายเงินมัดจำ', onTap: () {}),
      ],
    ),
    DrawerItem(
      key: 'accounts',
      icon: Icons.account_box,
      title: 'บัญชี',
      menuItem: [
        MenuItem(
          title: 'ผังบัญชี',
          onTap:
              () => Navigator.of(
                GlobalKeepings.context,
              ).pushNamed(RoutePaths.chartOfAccount),
        ),
        MenuItem(title: 'งบทดลอง', onTap: () {}),
      ],
    ),
    DrawerItem(
      key: 'master',
      icon: Icons.table_chart,
      title: 'ข้อมูล',
      menuItem: [
        MenuItem(title: 'สินค้า/บริการ', onTap: () {}),
        MenuItem(
          title: 'หน่วย',
          onTap:
              () => Navigator.of(
                GlobalKeepings.context,
              ).pushNamed(RoutePaths.unitMaster),
        ),
        MenuItem(title: 'ผู้ติดต่อ', onTap: () {}),
      ],
    ),
    DrawerItem(
      key: 'setting',
      icon: Icons.settings,
      title: 'ตั้งค่า',
      menuItem: [MenuItem(title: 'บัญชี', onTap: () {})],
    ),
    DrawerItem(
      key: 'logout',
      icon: Icons.logout,
      title: 'ออกจากระบบ',
      menuItem: [],
    ),
  ];
}
