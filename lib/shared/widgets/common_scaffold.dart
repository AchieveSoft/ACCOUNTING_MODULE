import 'dart:io';

import 'package:accounting_module/blocs/common_scaffold/bloc.dart';
import 'package:accounting_module/constants.dart';
import 'package:accounting_module/extensions/build_context.dart';
import 'package:accounting_module/utils/dialog_util.dart';
import 'package:accounting_module/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:accounting_module/configs/drawer_items.dart';
import 'package:accounting_module/models/drawer_item.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

// ignore: must_be_immutable
class _Menu extends StatefulWidget {
  final String drawerKey;
  final IconData icon;
  final String title;
  final List<MenuItem> menuItems;
  Function? onTap;

  _Menu({
    required this.drawerKey,
    required this.icon,
    required this.title,
    required this.menuItems,
    // ignore: unused_element_parameter
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<_Menu> {
  bool _isShowItem = false;

  void _toggle() => setState(() {
    _isShowItem = !_isShowItem;
  });

  Widget _buildMenuItem(String title, Function onTap) => ListTile(
    iconColor: Colors.white,
    textColor: const Color.fromRGBO(255, 255, 255, 1),
    leading: Icon(Icons.label),
    title: Text(title, style: TextStyle(fontSize: 14)),
    onTap: () {
      onTap();
      context.readCommonScaffoldBloc().add(
        CommonScaffoldSelectMenuEvent(key: widget.drawerKey, title: title),
      );
    },
  );

  @override
  initState() {
    super.initState();

    final CommonScaffoldState state = context.readCommonScaffoldBloc().state;

    if (state.currentSelectKey == widget.drawerKey) {
      setState(() {
        _isShowItem = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> menuItemsToShow =
        _isShowItem
            ? widget.menuItems
                .map((item) => _buildMenuItem(item.title, item.onTap))
                .toList()
            : [];

    return Padding(
      padding: EdgeInsets.only(top: 16, left: 8, bottom: 16, right: 8),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (widget.menuItems.isNotEmpty) {
                  _toggle();
                } else {
                  widget.onTap?.call();
                }
              },
              child: Row(
                children: [
                  Icon(widget.icon, color: Colors.white),
                  SizedBox(width: 16),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  widget.menuItems.isNotEmpty
                      ? Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_right, color: Colors.white),
                          ],
                        ),
                      )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            ...menuItemsToShow,
          ],
        ),
      ),
    );
  }
}

class _SliderMenu extends StatelessWidget {
  Widget _buildProfile(String name, ImageProvider<Object> profileIamge) =>
      Column(
        children: [
          CircleAvatar(radius: 62, backgroundImage: profileIamge),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Constants.primaryColor1, Constants.primaryColor2],
        begin: Alignment.topLeft,
        end: Alignment.topRight,
      ),
    ),
    child: ListView(
      children: [
        SizedBox(height: 32),
        _buildProfile(
          "อุซูมากิ นารูโตะ",
          Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIKGoqaUJEJixGDrPNtmpFy1iBFyc0xPZirQ&s',
          ).image,
        ),
        Padding(padding: EdgeInsets.all(8), child: Divider()),
        ...DrawerItemConfig.items.map(
          (item) => _Menu(
            drawerKey: item.key,
            icon: item.icon,
            title: item.title,
            menuItems: item.menuItem,
          ),
        ),
      ],
    ),
  );
}

class CommonScaffold extends StatefulWidget {
  final Widget child;

  const CommonScaffold({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  final double _drawerWidth = 180;

  Widget _buildMenuItem(IconData icon, String text) => SizedBox(
    width: 170,
    height: 90,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Color(0XFF1CBD9D)),
            SizedBox(width: 8),
            Text(text, style: TextStyle(color: Color(0XFF818181))),
          ],
        ),
      ),
    ),
  );

  Widget _buildWindowsIcons() =>
      Constants.isDesktopKioskMode
          ? Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Dialogutil.showConfirmDialog(
                      title: 'ยืนยันการดำเนินการ',
                      text: 'คุณต้องการปิดโปรแกรมใช่หรือไม่',
                      onConfirm: () {
                        exit(0);
                      },
                      onCancel: () {},
                    );
                  },
                ),
                MediaQueryUtil.isDesktopScreen == true
                    ? SizedBox(width: _drawerWidth - 16)
                    : SizedBox.shrink(),
              ],
            ),
          )
          : SizedBox.shrink();

  Widget _appBarIconWrap({required Widget icon, Function? onClick}) => Padding(
    padding: EdgeInsets.only(right: 8),
    child: InkWell(
      onTap: () {
        onClick?.call();
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(50),
        ),
        child: icon,
      ),
    ),
  );

  Widget _buildAppbarOptions() => Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _appBarIconWrap(icon: Icon(Icons.grid_4x4)),
        _appBarIconWrap(icon: Icon(Icons.notifications)),
        _appBarIconWrap(icon: Icon(Icons.chat_rounded)),
        _appBarIconWrap(icon: Icon(Icons.person_3)),
        MediaQueryUtil.isDesktopScreen && !Constants.isDesktopKioskMode
            ? SizedBox(width: _drawerWidth - 16)
            : SizedBox.shrink(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQueryUtil.isDesktopScreen) {
        _sliderDrawerKey.currentState?.openSlider();
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Container(width: double.infinity, color: Colors.white),
          SizedBox(
            width: double.infinity,
            height: 180,
            child: Image.asset(
              'assets/images/default_nav_bg.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 16,
            left: 34,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 72,
                    child: Image.asset(
                      'assets/images/temp_logo.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 79,
                        child: CircleAvatar(
                          radius: 62,
                          backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIKGoqaUJEJixGDrPNtmpFy1iBFyc0xPZirQ&s',
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Naruto',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                                size: 28,
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          Text(
                            'Business Owner',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 32,
            child: Container(
              width: MediaQuery.of(context).size.width - 64,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMenuItem(Icons.dashboard, 'Dashboard'),
                  _buildMenuItem(Icons.attach_money, 'Revenue'),
                  _buildMenuItem(Icons.money_off, 'Expenses'),
                  _buildMenuItem(Icons.contacts, 'Contacts'),
                  _buildMenuItem(Icons.inventory, 'Products'),
                  _buildMenuItem(Icons.account_balance, 'Finances'),
                  _buildMenuItem(Icons.account_box, 'Accounts'),
                  _buildMenuItem(Icons.folder, 'File Vault'),
                  _buildMenuItem(Icons.settings, 'Settings'),
                ],
              ),
            ),
          ),
          Positioned(top: 300, left: 0, child: widget.child),
        ],
      ),
    );
  }
}
