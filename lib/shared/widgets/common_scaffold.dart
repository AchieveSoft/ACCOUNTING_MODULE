import 'package:accounting_module/blocs/common_scaffold/bloc.dart';
import 'package:accounting_module/configs/routes.dart';
import 'package:accounting_module/core/global_keepings.dart';
import 'package:accounting_module/extensions/build_context.dart';
import 'package:accounting_module/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:accounting_module/configs/drawer_items.dart';
import 'package:accounting_module/models/drawer_item.dart';

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

class CommonScaffold extends StatefulWidget {
  final Widget child;

  const CommonScaffold({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  Widget _buildMenuItem(IconData icon, String text) => InkWell(
    onTap: () {
      Navigator.of(GlobalKeepings.context).pushNamed(RoutePaths.chartOfAccount);
    },
    child: SizedBox(
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
    ),
  );

  @override
  Widget build(BuildContext context) {
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
              width: MediaQueryUtil.getScreenWidth() - 64,
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
              width: MediaQueryUtil.getScreenWidth() - 64,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    DrawerItemConfig.items
                        .map((item) => _buildMenuItem(item.icon, item.title))
                        .toList(),
              ),
            ),
          ),
          Positioned(
            top: 248,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0XFFF9F9F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQueryUtil.getScreenHeight(),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQueryUtil.getScreenHeight(),
                        child: widget.child,
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
  }
}
