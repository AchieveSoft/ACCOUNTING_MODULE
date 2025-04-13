import 'package:flutter/widgets.dart';

class MenuItem {
  final String title;
  final Function onTap;

  MenuItem({required this.title, required this.onTap});
}

class DrawerItem {
  final String key;
  final IconData icon;
  final String title;
  final List<MenuItem> menuItem;
  Function? onTap;

  DrawerItem({
    required this.key,
    required this.icon,
    required this.title,
    required this.menuItem,
    this.onTap,
  });
}
