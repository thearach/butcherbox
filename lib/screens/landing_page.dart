import 'package:butcherbox/butch_widgets/bottom_menu.dart';
import 'package:butcherbox/screens/home.dart';
import 'package:butcherbox/screens/home_screen.dart';
import 'package:butcherbox/screens/home_screen2.dart';
import 'package:butcherbox/screens/signing_in.dart';
import 'package:butcherbox/services/auth.dart';
import 'package:butcherbox/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return SigningIn.create(context);
          }
          // return Provider<Database>(
          //     create: (_) => FireStoreDatabase(uid: user.uid), child: Home());
          return HomeScreen2();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
