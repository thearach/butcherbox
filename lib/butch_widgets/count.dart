import 'package:flutter/material.dart';

class Count extends ChangeNotifier {
  int _counter = 0;
  int get counts => _counter;

  void incrementCounter() {
    if (_counter >= 0) {
      _counter++;
      notifyListeners();
    }
  }

  void decreaseCounter() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }
}
