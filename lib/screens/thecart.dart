import 'dart:math';
import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/butch_widgets/count.dart';
import 'package:butcherbox/butch_widgets/showAlertDialog.dart';
import 'package:butcherbox/models/ordersmodel.dart';
import 'package:butcherbox/models/products.dart';
import 'package:butcherbox/screens/checkout.dart';
import 'package:butcherbox/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  final List<Products> _cart;
  int sum;
  Cart(this._cart, this.sum);
  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);
  List<Products> _cart;
  int sum;

  @override
  Widget build(BuildContext context) {
    final counting = Provider.of<Count>(context, listen: false);
    //int cartIndex;

    //var items = _cart[cartIndex];

    // void _finalPrice() {
    //   var prices = [];
    //   int sum = 0;
    //   _cart.forEach((items) {
    //     // sum = sum + items.totalPrice;
    //     sum += items.totalPrice;
    //     print(sum);
    //     return Text('$sum');
    //   });
    // }
    int sum = 0;
    String finalPrice() {
      _cart.forEach((items) {
        // sum = sum + items.totalPrice;
        sum += items.totalPrice;
        print(sum);
      });
      return 'N$sum';
    }

    // Random random = Random();
    // int orderMin = 100000;
    // int orderMax = 200000;
    // int orderId = orderMin + random.nextInt(orderMax);

    _initiateOrder(BuildContext context) {
      if (_cart.isNotEmpty) {
        Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) => Checkout(_cart, sum)));
      } else {
        showAlertDialog(context,
            title: 'Cart is Empty',
            content: 'Add items to cart and try again',
            defaultActionText: 'OK');
      }
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green[200],
          title: Text(
            'Cart',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green[900]),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/butchboxbgimagedark.png'))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                'YOUR ITEMS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView.builder(
                  itemCount: _cart.length,
                  shrinkWrap: true,
                  itemBuilder: (context, cardIndex) {
                    var items = _cart[cardIndex];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  items.product,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.green[900],
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'X${counting.counts}',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(width: 8),
                                //Text('${items.price}'),
                                Text(
                                  'N${items.totalPrice}',
                                  style: TextStyle(
                                      color: Colors.green[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete_outline,
                                      size: 18.0,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _cart.remove(items);
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              ButcherButtons(
                  buttonText: 'ADD MORE ITEMS',
                  onPressed: () => Navigator.pop(context)),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.fromLTRB(80.0, 20.0, 40.0, 20.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 60.0,
                  //width: 60.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            Text('TOTAL:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900],
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(finalPrice(),
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.0),
                      ButcherButtons(
                        buttonText: 'CHECKOUT',
                        onPressed: () => _initiateOrder(context),
                      )
                    ],
                  ),
                ),
              )
              // Text(
              //   finalPrice(),
              //   style: TextStyle(color: Colors.white),
              // ),
              // )
              // Text(
              //   '${_cart[_cart.length - 1].totalPrice}',
              //   //   '$_finalPrice',
              //   style: TextStyle(color: Colors.white),
              // )
            ],
          ),
        ));
  }
}
