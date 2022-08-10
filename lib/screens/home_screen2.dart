import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/butch_widgets/location_drop.dart';
import 'package:butcherbox/models/ordersmodel.dart';
import 'package:butcherbox/screens/home.dart';
import 'package:butcherbox/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen2 extends StatefulWidget {
  // HomeScreen({this.location});
  //final String location;
  @override
  State<HomeScreen2> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
  final List<String> items = <String>[
    'Morgan Street Ojodu',
    'Agidingbi',
    'Ogba',
    'B and T Market Ojokoro',
    'Ojodu Berger'
  ];

  String dropDownValue = 'Morgan Street Ojodu';
  String get vendorLocation => dropDownValue;
  // Future<void> _createOrder(BuildContext context) async {
  @override
  Widget build(BuildContext context) {
    //final database = Provider.of<Database>(context, listen: false);
    //database.readOrders();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[200],
        title: Text(
          'Butcher Box',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green[900]),
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.person),
        //       onPressed: () {
        //         Navigator.of(context, rootNavigator: true)
        //             .pushNamed('/account');
        //       })
        // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/butchboxbgimagedark.png'),
                ),
              ),
              padding: EdgeInsets.all(32.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      'Find a Butcher Box near you',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900]),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      'Select a location from the list below',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.green[200],
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Colors.green[900], width: 2.0)),
                        child: DropdownButton<String>(
                          onChanged: (String newValue) {
                            setState(() {
                              dropDownValue = newValue;
                            });
                          },
                          value: dropDownValue,
                          items: items.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      'Pickup Location is \n $dropDownValue',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(height: 200.0),
                    ButcherButtons(
                      buttonText: 'Start Shopping',
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    Home(location: dropDownValue)));
                      },
                      /* Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => StoreScreen()));*/
                      //return CupertinoTabView();
                      /*return CupertinoTabView(
                          routes: <String, WidgetBuilder>{
                            '/store': (context) => StoreScreen()
                          },
                          builder: (context) => StoreScreen(),
                        );*/
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
