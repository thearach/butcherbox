import 'package:butcherbox/logic/StoreLogic.dart';
import 'package:butcherbox/screens/maincart.dart';
import 'package:butcherbox/screens/thecheckout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key key, this.location}) : super(key: key);
  final String location;

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<StoreLogic>(context);
    store.activeProduct.totalPrice =
        store.activeProduct.quantity * store.activeProduct.price;
    int mainPrice = store.activeProduct.totalPrice;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green[200],
          title: Text(
            store.activeProduct.name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green[900]),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainCart(location: location)));
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, top: 15.0),
                    child: Icon(Icons.shopping_cart, size: 30.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: CircleAvatar(
                      radius: 10.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        //'0',
                        // store.cart.length.toString(),
                        store.getCartQuantity().toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/butchboxbgimagedark.png'))),
          child: Center(
            child: Container(
              color: Colors.white,
              child: Column(children: [
                Image.asset(store.activeProduct.imageText,
                    width: 200, height: 200),
                Text(store.activeProduct.name),
                Text(store.activeProduct.price.toString()),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          store.addOneItemToCart(store.activeProduct);
                        }),
                    Text(store.activeProduct.quantity.toString()),
                    IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          store.removeOneItemToCart(store.activeProduct);
                        }),
                  ],
                ),
                Text('N$mainPrice'),
                Text(location)
              ]),
            ),
          ),
        ));
  }
}
