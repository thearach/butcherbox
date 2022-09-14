import 'dart:math';
import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/logic/StoreLogic.dart';
import 'package:butcherbox/models/ordersmodel.dart';
import 'package:butcherbox/screens/thanks.dart';
import 'package:butcherbox/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TheCheckout extends StatelessWidget {
  TheCheckout({this.sum, this.location});
  int sum;
  String location;

  Random random = Random();
  int orderMin = 100000;
  int orderMax = 200000;

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<StoreLogic>(context);
    int orderId = orderMin + random.nextInt(orderMax);

    Future<void> _createOrder(BuildContext context) async {
      try {
        final database = Provider.of<Database>(context, listen: false);
        await database.createOrder(Order(
            // items: [
            //   {'item': 'ButcherBox Mini pack', 'quantity': 2, 'Price': 1800},
            //   {'item': 'ButcherBox Combo pack', 'quantity': 4, 'Price': 4000},
            // ],
            items: store.cart,
            location: location,
            price: sum,
            orderId: orderId,
            time: Timestamp.now()
        ));
        if (store.cart.isNotEmpty) {
          Navigator.of(context, rootNavigator: true)
              .push(MaterialPageRoute(builder: (context) => Thanks()));
        } else {
          print('Cart Empty');
        }
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[200],
        title: Text(
          'Checkout',
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
            Expanded(
              child: Container(
                color: Colors.white,
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: store.cart.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          //var items = _cart[index];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    store.cart[i].name,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.green[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'N${store.cart[i].totalPrice}',
                                    style: TextStyle(
                                        // color: Colors.green[900],
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                            ],
                          );
                        },
                      ),
                      Divider(
                        height: 10.0,
                        thickness: 3.0,
                        color: Colors.green[200],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'TOTAL:',
                            style: TextStyle(
                                color: Colors.green[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          Text(
                            '$sum',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Delivery Method: Pick Up',
                        style: TextStyle(
                            color: Colors.green[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Payment Option: Cash',
                        style: TextStyle(
                            color: Colors.green[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      ButcherButtons(
                        buttonText: 'CHECKOUT',
                        onPressed: () => _createOrder(context),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
