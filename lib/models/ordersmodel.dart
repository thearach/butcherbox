import 'package:butcherbox/models/productsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Order {
  Order(
      {@required this.items,
      //this.theItems,
      @required this.id,
      this.location,
      this.orderId,
      this.time,
      @required this.price});

  final List<ProductsModel> items;
  final String id;
  //final List<Map> items;
  //final Map theItems;
  final String location;
  final int orderId;
  //final DateTime time;
  final Timestamp time;
  final int price;

  factory Order.fromMap(Map<String, dynamic> data, String documentID) {
    if (data == null) {
      return null;
    }
    //final List<Map> items = data['items'];
    //final List<ProductsModel> items = data['items'];
    final List<ProductsModel> items = [];
    // final List<ProductsModel> items = List<ProductsModel>.from(data['items'])
    //     .map((e) => e.fromJson())
    //     .cast<ProductsModel>()
    //     .toList();
    //final Map theItems = data['items'];
    // final List<ProductsModel> items = List<ProductsModel>.from(data['items'])
    //     .map((e) => e.toJson())
    //     .cast<ProductsModel>()
    //     .toList();
    final String location = data['location'];
    final int price = data['price'];
    final int orderId = data['orderId'];
    //final DateTime time = data['time'];
    final Timestamp time = data['time'];

    return Order(
      items: items,
      id: documentID,
      //theItems: theItems,
      location: location,
      price: price,
      orderId: orderId,
      time: time,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'item': items,
  //     //'items': theItems,
  //     'location': location,
  //     'orderId': orderId,
  //     'time': time,
  //     'price': price
  //   };
  // }

  Map<String, dynamic> toMap() {
    return {
      'item': items.map((e) => e.toJson()).toList(),
      //'items': items,
      'location': location,
      'orderId': orderId,
      'time': time,
      'price': price
    };
  }
}
