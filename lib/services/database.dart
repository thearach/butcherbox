import 'package:butcherbox/models/ordersmodel.dart';
import 'package:butcherbox/services/api_path.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:butcherbox/services/firestore_service.dart';

abstract class Database {
  Future<void> createOrder(Order order);
  Stream<List<Order>> ordersStream();
  Stream getOrdersStream();
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FireStoreService.instance;

  Future<void> createOrder(Order order) => _service.setData(
        //path: APIPath.order(uid, 'orderdetails'), data: order.toMap());
        path: APIPath.order(uid, 'orderdetails'),
        data: order.toMap(),
      );

  Stream<List<Order>> ordersStream() => _service.collectionStream(
      path: APIPath.orders(uid), builder: (data) => Order.fromMap(data));

  Stream getOrdersStream() =>
      _service.getCollectionStream(path: APIPath.orders(uid));
}
