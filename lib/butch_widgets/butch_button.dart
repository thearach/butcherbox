import 'package:flutter/material.dart';

class ButcherButtons extends StatelessWidget {
  ButcherButtons({this.buttonText, this.onPressed})
      : assert(buttonText != null);
  //final Widget child;
  @required
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.green[200],
        elevation: 5.0,
        onSurface: Colors.black,
      ),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Colors.green[900]),
      ),
      onPressed: onPressed,
    );
  }
}
