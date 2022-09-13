import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:butcherbox/services/firestore_service.dart';
import 'package:butcherbox/services/database.dart';
import 'package:provider/provider.dart';

class Orders2 extends StatefulWidget {
  @override
  _Orders2State createState() => _Orders2State();
}

class _Orders2State extends State<Orders2> {
  // Database database;
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[200],
        title: Text(
          'Orders',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green[900]),
        ),
      ),
      body: StreamBuilder(
        stream: database.getOrdersStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
