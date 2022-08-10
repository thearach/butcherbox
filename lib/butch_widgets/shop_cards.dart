import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/butch_widgets/count.dart';
import 'package:butcherbox/butch_widgets/main_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopCards extends StatelessWidget {
  ShopCards(
      {this.imageText,
      this.counter,
      this.productDesc,
      this.beefChicken,
      this.priceText,
      this.onPressed});

  @required
  final String imageText;
  final Widget counter;
  final String productDesc;
  final String beefChicken;
  final String priceText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final _letsCount = Provider.of<Count>(context, listen: false);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(right: 20.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imageText, width: 150.0, height: 150.0),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.0),
                  Text(productDesc,
                      style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600)),
                  Text(beefChicken),
                  Text(priceText,
                      style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //SizedBox(width: 150.0),
                      MainCounter(),
                      ButcherButtons(
                          buttonText: 'ADD TO CART',
                          onPressed: () {
                            int quantity = _letsCount.counts;
                            print(quantity);
                          })
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
