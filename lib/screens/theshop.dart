import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/logic/StoreLogic.dart';
import 'package:butcherbox/screens/productpage.dart';
import 'package:butcherbox/screens/thecart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TheShop extends StatelessWidget {
  const TheShop({Key key, this.location}) : super(key: key);
  final String location;

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<StoreLogic>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[200],
        title: Text(
          'Store',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green[900]),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/butchboxbgimagedark.png'))),

        //decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Text(location, style: TextStyle(color: Colors.white)),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: store.products.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    int realPrice = store.products[i].price;
                    return Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(store.products[i].imageText,
                                width: 150.0, height: 150.0),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 30.0),
                                      Text(store.products[i].name,
                                          style: TextStyle(
                                              color: Colors.green[900],
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600)),
                                      Text(store.products[i].category,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black)),
                                      Text('N$realPrice',
                                          // .toString(),
                                          style: TextStyle(
                                              color: Colors.green[900],
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ButcherButtons(
                                                buttonText: 'ADD',
                                                onPressed: () {
                                                  store.setActiveProduct(
                                                      store.products[i]);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductPage(
                                                                  location:
                                                                      location)));
                                                }),
                                          ]),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 15.0,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
