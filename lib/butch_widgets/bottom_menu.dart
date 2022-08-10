import 'package:butcherbox/butch_widgets/shop_cards.dart';
import 'package:butcherbox/models/products.dart';
import 'package:flutter/material.dart';
import 'package:butcherbox/screens/store_screen.dart';

class BottomMenu extends StatefulWidget {
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  List<Products> _cart = [];
  int currentIndex = 0;
  //final screens = [HomeScreen(), StoreScreen(), Cart(_cart)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green[200],
      body: IndexedStack(
        index: currentIndex,
        // children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green[200],
        selectedItemColor: Colors.black26,
        unselectedItemColor: Colors.green[900],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            //backgroundColor: Colors.green[200],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Store',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          //BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Account')
        ],
      ),
    );
  }
}
