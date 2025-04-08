import 'package:flutter/material.dart';
import 'package:accounting_module/models/drawer_item.dart';

class DrawerItemConfig {
  static List<DrawerItem> items = [
    DrawerItem(icon: Icons.dashboard, title: 'แดชบอร์ด', menuItem: []),
    DrawerItem(
      icon: Icons.attach_money,
      title: 'รายรับ',
      menuItem: [
        MenuItem(title: 'ใบเสนอราคา', onTap: () {}),
        MenuItem(title: 'ใบแจ้งหนี้', onTap: () {}),
        MenuItem(title: 'ใบเสร็จรับเงิน', onTap: () {}),
      ],
    ),
    DrawerItem(
      icon: Icons.book_online,
      title: 'รายจ่าย',
      menuItem: [
        MenuItem(title: 'ใบสั่งซิ้อ', onTap: () {}),
        MenuItem(title: 'ใบจ่ายเงินมัดจำ', onTap: () {}),
      ],
    ),
    DrawerItem(
      icon: Icons.account_box,
      title: 'บัญชี',
      menuItem: [
        MenuItem(title: 'ผังบัญชี', onTap: () {}),
        MenuItem(title: 'งบทดลอง', onTap: () {}),
      ],
    ),
    DrawerItem(
      icon: Icons.settings,
      title: 'ตั้งค่า',
      menuItem: [MenuItem(title: 'บัญชี', onTap: () {})],
    ),
    DrawerItem(icon: Icons.logout, title: 'ออกจากระบบ', menuItem: []),
  ];
}
