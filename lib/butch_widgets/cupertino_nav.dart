import 'package:butcherbox/butch_widgets/tab_items.dart';
import 'package:butcherbox/screens/home_screen.dart';
import 'package:butcherbox/screens/store_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoNav extends StatelessWidget {
  const CupertinoNav(
      {Key key,
      @required this.currentTab,
      @required this.onSelectTab,
      @required this.widgetBuilders})
      : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        _buildItem(TabItem.Store),
        // _buildItem(TabItem.Cart),
        _buildItem(TabItem.Account)
      ], onTap: (index) => onSelectTab(TabItem.values[index])),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
            builder: (context) => widgetBuilders[item](context));
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabitem) {
    final itemData = TabItemData.allItems[tabitem];
    final color = currentTab == tabitem ? Colors.green[900] : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(itemData.icon, color: color),
      label: itemData.title,
      // title: Text(
      //   itemData.title,
      //   style: TextStyle(color: color),
      // )
    );
  }
}
