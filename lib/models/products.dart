import 'package:flutter/material.dart';

class Products {
  Products(
      {this.imageText,
      this.product,
      this.category,
      this.price,
      this.counter,
      this.totalPrice});

  final String imageText;
  final String product;
  final String category;
  final int price;
  final Widget counter;
  int totalPrice;
}
