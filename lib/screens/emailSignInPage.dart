import 'package:butcherbox/screens/EmailSignInFormChange.dart';
import 'package:flutter/material.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailSignInFormChange.create(context),
      ],
    );
  }
}
