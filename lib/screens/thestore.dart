import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/butch_widgets/count.dart';
import 'package:butcherbox/butch_widgets/main_counter.dart';
import 'package:butcherbox/models/products.dart';
import 'package:butcherbox/screens/thecart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TheStore extends StatefulWidget {
  @override
  _TheListsState createState() => _TheListsState();
}

class _TheListsState extends State<TheStore> {
  List<Products> _store = [];
  List<Products> _cart = [];
  int sum;

  @override
  void initState() {
    super.initState();
    _mainProducts();
  }

  @override
  Widget build(BuildContext context) {
    final counting = Provider.of<Count>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[200],
        title: Text(
          'Store',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green[900]),
        ),
        actions: [
          // IconButton(
          //     icon: Icon(Icons.shopping_cart),
          //     onPressed: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => Cart(_cart)));
          //     }),
          GestureDetector(
            child: Stack(
              // alignment: Alignment.centerRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, top: 15.0),
                  child: Icon(Icons.shopping_cart, size: 30.0),
                ),
                if (_cart.length > 0)
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: CircleAvatar(
                      radius: 10.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        _cart.length.toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ],
            ),
            onTap: () {
              if (_cart.isNotEmpty)
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Cart(_cart, sum)));
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/butchboxbgimagedark.png'))),

        //decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(children: [
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemCount: _store.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var items = _store[index];
                items.totalPrice = items.price * counting.counts;
                return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(items.imageText,
                            width: 150.0, height: 150.0),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30.0),
                                  Text(items.product,
                                      style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600)),
                                  Text(items.category,
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.black)),
                                  Text('N${items.price}',
                                      style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
//SizedBox(width: 150.0),
                                        ChangeNotifierProvider<Count>(
                                          create: (_) => Count(),
                                          child: MainCounter(),
                                        ),
                                        ButcherButtons(
                                            buttonText: 'ADD',
                                            onPressed: () {
                                              setState(() {
                                                if (!_cart.contains(items)) {
                                                  // int allPrice = items.price * items.counter.counts;
                                                  items.totalPrice =
                                                      items.price *
                                                          counting.counts;
                                                  _cart.add(items);
                                                  print('Added to Cart');
                                                } else
                                                  _cart.remove(items);
                                              });
                                            }),
                                      ]),
                                ],
                              ),
                            ))
                      ],

                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Text(items.product),
                      //     SizedBox(width: 6),
                      //     Text('${items.price}'),
                      //     items.counter,
                      //     //Text('${items.totalPrice}'),
                      //     ElevatedButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             if (!_cart.contains(items)) {
                      //               // int allPrice = items.price * items.counter.counts;
                      //               items.totalPrice =
                      //                   items.price * counting.counts;
                      //               _cart.add(items);
                      //               print('Added to Cart');
                      //             }
                      //             // else
                      //             //   _cart.remove(items);
                      //           });
                      //         },
                      //         child: Text('Add to Cart'))
                      //   ],
                      // ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 15.0,
                );
              },
            )
          ]),
        ),
      ),
    );
  }

  void _mainProducts() {
    var productList = <Products>[
      Products(
          imageText: 'images/biggiecombo.jpg',
          product: 'ButcherBox Mini Combo Pack',
          category: 'Beef and Chicken',
          price: 500,
          counter: MainCounter()),
      Products(
          imageText: 'images/thecombopack.jpg',
          product: 'ButcherBox Biggie Combo',
          category: 'Beef and Chicken',
          price: 950,
          counter: MainCounter()),
      Products(
          imageText: 'images/regular1kg.jpg',
          product: 'ButcherBox Regular 1kg',
          category: 'Beef',
          price: 1800,
          counter: MainCounter()),
      Products(
          imageText: 'images/minicombopack.jpg',
          product: 'ButcherBox Mini Combo Pack',
          category: 'Beef and Chicken',
          price: 500,
          counter: MainCounter()),
      Products(
          imageText: 'images/regular500.jpg',
          product: 'ButcherBox Regular 500g',
          category: 'Beef',
          price: 1800,
          counter: MainCounter()),
    ];
    setState(() {
      _store = productList;
    });
  }
}

// Row(
// //mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Image.asset(imageText, width: 150.0, height: 150.0),
// Expanded(
// flex: 2,
// child: Padding(
// padding: EdgeInsets.only(left: 12.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SizedBox(height: 30.0),
// Text(productDesc,
// style: TextStyle(
// color: Colors.green[900],
// fontSize: 16.0,
// fontWeight: FontWeight.w600)),
// Text(beefChicken),
// Text(priceText,
// style: TextStyle(
// color: Colors.green[900],
// fontSize: 20.0,
// fontWeight: FontWeight.bold)),
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// //SizedBox(width: 150.0),
// MainCounter(),
// ButcherButtons(
// buttonText: 'ADD TO CART',
// onPressed: () {
// int quantity = _letsCount.counts;
// print(quantity);
// })
// ],
// )
