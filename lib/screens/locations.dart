import 'package:butcherbox/screens/account_screen.dart';
import 'package:flutter/material.dart';

class Locations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[200],
        title: Text(
          'Locations',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green[900]),
        ),
      ),
    );
  }
}
