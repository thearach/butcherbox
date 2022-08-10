import 'package:butcherbox/butch_widgets/count.dart';
import 'package:butcherbox/butch_widgets/shop_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[200],
        title: Text(
          'Store',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green[900]),
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.person),
        //       onPressed: () {
        //         Navigator.of(context, rootNavigator: true)
        //             .pushNamed('/account');
        //       })
        // ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/butchboxbgimagedark.png'))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Column(
                  children: [
                    ShopCards(
                        imageText: 'images/biggiecombo.jpg',
                        productDesc: 'Butcher Box Biggie Combo',
                        beefChicken: 'Beef and Chicken',
                        priceText: 'N1000',
                        onPressed: () {}),
                    SizedBox(height: 8.0),
                    ShopCards(
                        imageText: 'images/thecombopack.jpg',
                        productDesc: 'Butcher Box Midi Combo Pack',
                        beefChicken: 'Beef and Chicken',
                        priceText: 'N900',
                        onPressed: () {}),
                    SizedBox(height: 8.0),
                    ShopCards(
                        imageText: 'images/regular1kg.jpg',
                        productDesc: 'Butcher Box Regular 1kg',
                        beefChicken: 'Beef',
                        priceText: 'N1800',
                        onPressed: () {}),
                    SizedBox(height: 8.0),
                    ShopCards(
                        imageText: 'images/regular500.jpg',
                        productDesc: 'Butcher Box Regular 500g',
                        beefChicken: 'Beef',
                        priceText: 'N500',
                        onPressed: () {}),
                    SizedBox(height: 8.0),
                    ShopCards(
                        imageText: 'images/minicombopack.jpg',
                        productDesc: 'Butcher Box Mini Combo Pack',
                        beefChicken: 'Beef and Chicken',
                        priceText: 'N500',
                        onPressed: () {}),
                    SizedBox(height: 60.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
