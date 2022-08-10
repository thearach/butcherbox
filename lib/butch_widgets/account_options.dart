import 'package:flutter/material.dart';

class AccountOptions extends StatelessWidget {
  AccountOptions(
      {@required this.headOption,
      @required this.subOption,
      @required this.iconPlace,
      @required this.enter});

  final String headOption;
  final String subOption;
  final IconData iconPlace;
  final VoidCallback enter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.green[200], width: 4.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
        // height: 50.0,
        child: ListTile(
          onTap: enter,
          dense: true,
          leading: Icon(iconPlace, color: Colors.black),
          title: Text(
            headOption,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.green[900]),
          ),
          subtitle: Text(subOption,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          trailing: Icon(Icons.arrow_right, color: Colors.green[900]),
        ),
      ),
    );
  }
}
