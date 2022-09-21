import 'package:butcherbox/butch_widgets/order_list_tile.dart';
import 'package:butcherbox/models/ordersmodel.dart';
import 'package:butcherbox/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      //bottomNavigationBar: Home(),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Order>>(
        stream: database.ordersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final orders = snapshot.data;
            // final children =
            // orders.map((order) => Text(order.location)).toList();
            final children =
                orders.map((order) => OrderListTile(order: order)).toList();
            return ListView(children: children);
          }
          if (snapshot.hasError) {
            return Center(child: Text('Some Error Occurred'));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
