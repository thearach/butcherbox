import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/logic/StoreLogic.dart';
import 'package:butcherbox/screens/home.dart';
import 'package:butcherbox/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen2.dart';

class Thanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<StoreLogic>(context);
    return Container(
      color: Colors.green[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 120.0),
          Text('Thank You!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.green[900])),
          SizedBox(height: 50.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: (BorderRadius.all(Radius.circular(20.0)))),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.0),
                  Image.asset('images/tick.png',
                      height: 100.0, width: 100.0, alignment: Alignment.center),
                  SizedBox(height: 30.0),
                  Text(
                    'Your order has been placed successfully.',
                    style: TextStyle(fontSize: 12.0, color: Colors.black),
                  ),
                  Text('Thank you for your order.',
                      style: TextStyle(fontSize: 12.0, color: Colors.black)),
                  ButcherButtons(
                      buttonText: 'Back to Home',
                      onPressed: () {
                        store.cart.clear();
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen2()));
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
