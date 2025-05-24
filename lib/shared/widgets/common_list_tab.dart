import 'package:accounting_module/constants.dart';
import 'package:flutter/material.dart';

class CommonListTabItem {
  final String text;
  final Function? onTap;

  CommonListTabItem({required this.text, required this.onTap});
}

class CommonListTab extends StatefulWidget {
  final List<CommonListTabItem> items;

  const CommonListTab({super.key, required this.items});

  @override
  State<CommonListTab> createState() => _CommonListTabState();
}

class _CommonListTabState extends State<CommonListTab> {
  int _currentTabSelect = 0;

  void _selectTab(int index) => setState(() => _currentTabSelect = index);

  Widget _buildTabFocusUnderline() => Container(
    width: double.infinity,
    height: 3,
    decoration: BoxDecoration(
      color: Constants.primaryColor1,
      borderRadius: BorderRadius.circular(8),
    ),
  );

  Widget _buildTabItem(CommonListTabItem item, int index) => Padding(
    padding: EdgeInsets.only(left: index == 0 ? 0 : 8),
    child: InkWell(
      onTap: () {
        _selectTab(index);
        item.onTap?.call();
      },
      child: SizedBox(
        width: 90,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  item.text,
                  style:
                      index == _currentTabSelect
                          ? TextStyle(fontWeight: FontWeight.bold)
                          : null,
                ),
              ),
            ),
            index == _currentTabSelect
                ? _buildTabFocusUnderline()
                : SizedBox.shrink(),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    widget.items.asMap().forEach(
      (index, item) => items.add(_buildTabItem(item, index)),
    );

    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Constants.primaryColor2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(children: items),
    );
  }
}
