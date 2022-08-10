import 'package:flutter/material.dart';

class ProductCards extends StatelessWidget {
  ProductCards({this.cardImageText, this.labelText, this.tapIn});

  final String cardImageText;
  final String labelText;
  final VoidCallback tapIn;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: new InkWell(
        onTap: tapIn,
        child: Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
            height: 100.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(cardImageText))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  labelText,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.green[900],
                )
              ],
            )),
      ),
    );
  }
}
