class ProductsModel {
  ProductsModel(
      {this.id,
      this.imageText,
      this.pic,
      this.category,
      this.name,
      this.price,
      this.totalPrice,
      this.quantity});

  final String imageText;
  final int id;
  final String pic;
  final String name;
  final String category;
  final int price;
  int quantity;
  int totalPrice;

  Map<String, dynamic> toJson() {
    return {'name': name, 'quantity': quantity, 'price': totalPrice};
  }

  Map<String, dynamic> fromJson() {
    return {'name': name, 'quantity': quantity, 'price': totalPrice};
  }
}
