import 'package:butcherbox/models/ordersmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FireStoreService {
  FireStoreService._();
  static final instance = FireStoreService._();
  String dataDoc = Timestamp.now().toString();
  List<Order> theOrder = [];
  List<Order> getTheOrder() {
    return theOrder;
  }

  Future<void> setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.set(data);
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs
        .map(
          (snapshot) => builder(snapshot.data(), snapshot.id),
        )
        .toList());
  }

  // Stream<List<T>> getStream<T>({
  //   @required String path,
  //   @required T Function(Map<String, dynamic> data) builder,
  // }) {
  //   final reference = FirebaseFirestore.instance.collection(path);
  //   final snapshots = reference.snapshots();
  //   var data = snapshots.data
  // }
}
