import 'package:butcherbox/screens/account_screen.dart';
import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[200],
        title: Text(
          'Account Information',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green[900]),
        ),
        /* actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => AccountScreen()));
              })
        ],*/
      ),
    );
  }
}
