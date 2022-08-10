import 'package:butcherbox/butch_widgets/cupertino_nav.dart';
import 'package:butcherbox/butch_widgets/tab_items.dart';
import 'package:butcherbox/models/products.dart';
import 'package:butcherbox/screens/account_screen.dart';
import 'package:butcherbox/screens/store_screen.dart';
import 'package:butcherbox/screens/thecart.dart';
import 'package:butcherbox/screens/theshop.dart';
import 'package:butcherbox/screens/thestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key, this.location}) : super(key: key);
  final String location;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<Products> _cart = [];
  String get vendorLocation => widget.location;
  TabItem _currentTab = TabItem.Store;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.Store: (_) => TheShop(location: vendorLocation),
      //TabItem.Cart: (_) => Cart(_cart),
      TabItem.Account: (_) => AccountScreen(),
    };
  }

  void _select(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoNav(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders);
  }
}
