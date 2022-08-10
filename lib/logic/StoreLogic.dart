import 'package:butcherbox/models/productsModel.dart';
import 'package:flutter/material.dart';

class StoreLogic extends ChangeNotifier {
  List<ProductsModel> _products = [];
  List<ProductsModel> _cart = [];
  ProductsModel _activeProduct = null;

  StoreLogic() {
    _products = [
      ProductsModel(
        id: 001,
        imageText: 'images/biggiecombo.jpg',
        name: 'ButcherBox Mini Combo Pack',
        category: 'Beef and Chicken',
        price: 500,
        quantity: 0,
        totalPrice: 0,
      ),
      ProductsModel(
        id: 002,
        imageText: 'images/thecombopack.jpg',
        name: 'ButcherBox Biggie Combo',
        category: 'Beef and Chicken',
        price: 950,
        quantity: 0,
        totalPrice: 0,
      ),
      ProductsModel(
        id: 003,
        imageText: 'images/regular1kg.jpg',
        name: 'ButcherBox Regular 1kg',
        category: 'Beef',
        price: 1800,
        quantity: 0,
        totalPrice: 0,
      ),
      ProductsModel(
        id: 004,
        imageText: 'images/minicombopack.jpg',
        name: 'ButcherBox Mini Combo Pack',
        category: 'Beef and Chicken',
        price: 500,
        quantity: 0,
        totalPrice: 0,
      ),
      ProductsModel(
        id: 005,
        imageText: 'images/regular500.jpg',
        name: 'ButcherBox Regular 500g',
        category: 'Beef',
        price: 900,
        quantity: 0,
        totalPrice: 0,
      ),
    ];
    notifyListeners();
  }

  List<ProductsModel> get products => _products;
  List<ProductsModel> get cart => _cart;
  ProductsModel get activeProduct => _activeProduct;

  setActiveProduct(ProductsModel p) {
    _activeProduct = p;
  }

  addOneItemToCart(ProductsModel p) {
    ProductsModel found =
        _cart.firstWhere((a) => a.id == p.id, orElse: () => null);
    if (found != null) {
      found.quantity += 1;
    } else {
      _cart.add(p);
    }
    notifyListeners();
  }

  removeOneItemToCart(ProductsModel p) {
    ProductsModel found =
        _cart.firstWhere((a) => a.id == p.id, orElse: () => null);
    if (found != null && found.quantity == 0) {
      _cart.remove(p);
    } else {
      found.quantity -= 1;
    }
    notifyListeners();
  }

  removeProductFromCart(ProductsModel p) {
    cart.remove(p);
  }

  // int finalAmount() {
  //   int sum = 0;
  //   int i;
  //   int totalPrice = cart[i].quantity * cart[i].price;
  //   cart.forEach((items) {
  //     sum += items.totalPrice;
  //   });
  //   return sum;
  // }

  int finalAmount() {
    int i;
    int totalPrice = cart[i].quantity * cart[i].price;
    return totalPrice;
  }

  getCartQuantity() {
    int totalItems = 0;
    if (cart == null) return totalItems;
    for (int i = 0; i < cart.length; i++) {
      totalItems += cart[i].quantity;
    }
    return totalItems;
  }
}
