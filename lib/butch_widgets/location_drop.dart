import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationDrop extends StatefulWidget {
  @override
  _LocationDropState createState() => _LocationDropState();
}

class _LocationDropState extends State<LocationDrop> {
  final List<String> items = <String>[
    'Morgan Street Ojodu',
    'Agidingbi',
    'Ogba',
    'B and T Market Ojokoro',
    'Ojodu Berger'
  ];

  String dropDownValue = 'Morgan Street Ojodu';

  //Use this vendor location getter in the cart screen
  String get vendorLocation => dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.green[900], width: 2.0)),
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
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Pickup Location is \n $dropDownValue',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
