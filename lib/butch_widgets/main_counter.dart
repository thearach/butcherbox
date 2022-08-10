import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'count.dart';

class MainCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Count>(context, listen: false);

    return Expanded(
      flex: 1,
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.add, size: 12.0),
              onPressed: counter.incrementCounter),
          Text('${counter.counts}'),
          IconButton(
              icon: Icon(Icons.remove, size: 12.0),
              onPressed: counter.decreaseCounter),
        ],
      ),
    );
  }
}
