import 'package:butcherbox/models/ordersmodel.dart';
import 'package:flutter/material.dart';

class OrderListTile extends StatelessWidget {
  final Order order;

  const OrderListTile({Key key, @required this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Order No: ${order.orderId}',
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green[900]),
      ),
      trailing: Text(
        'Vendor: ${order.location}',
        style: TextStyle(fontSize: 16),
      ),
      // trailing: Text(
      //   'N${order.price}',
      //   style: TextStyle(
      //       fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
      // ),
      subtitle: ListView.builder(
          itemCount: order.items.length,
          //itemCount: order.items?.length ?? 0,
          //itemCount: (order.items == null) ? 0 : order.items.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Expanded(
              child: Column(
                children: [
                  Text('${order.items[i].name}'),
                  Text('${order.items[i].quantity.toString()}')
                ],
              ),
            );
          }),
      //dense: true,
      isThreeLine: true,
    );
  }
}
