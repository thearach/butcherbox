import 'package:flutter/material.dart';

enum TabItem { Store, Account }

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allItems = {
    TabItem.Store: TabItemData(title: 'Store', icon: Icons.shopping_basket),
    // TabItem.Cart: TabItemData(title: 'Cart', icon: Icons.shopping_cart),
    TabItem.Account: TabItemData(title: 'Account', icon: Icons.person),
  };
}
