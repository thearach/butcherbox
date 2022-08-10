import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/butch_widgets/showAlertDialog.dart';
import 'package:butcherbox/logic/StoreLogic.dart';
import 'package:butcherbox/screens/thecheckout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCart extends StatefulWidget {
  const MainCart({Key key, this.location}) : super(key: key);
  final String location;

  @override
  _MainCartState createState() => _MainCartState();
}

class _MainCartState extends State<MainCart> {
  String get vendorLocation => widget.location;
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<StoreLogic>(context);

    int sum = 0;
    String finalPrice() {
      store.cart.forEach((items) {
        //sum = sum + items.totalPrice;
        sum += items.totalPrice;
      });
      return 'N$sum';
    }

    _initiateOrder(BuildContext context) {
      if (store.cart.isNotEmpty) {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) =>
                TheCheckout(sum: sum, location: vendorLocation)));
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
              Center(
                child: Text('You are shopping at $vendorLocation',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView.builder(
                  itemCount: store.cart.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    int trueQuantity = store.cart[i].quantity;
                    int mainPrice =
                        store.cart[i].quantity * store.cart[i].price;
                    // var items = _cart[cardIndex];
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
                                  store.cart[i].name,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.green[900],
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'X$trueQuantity',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(width: 8),
                                //Text('${items.price}'),
                                Text(
                                  'N$mainPrice',
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
                                        store.cart.remove(store.cart[i]);
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
                                  //child: Text(store.finalAmount().toString(),
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
            ],
          ),
        ));
  }
}
