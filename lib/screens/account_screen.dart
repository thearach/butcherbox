import 'package:butcherbox/butch_widgets/account_options.dart';
import 'package:butcherbox/butch_widgets/showAlertDialog.dart';
import 'package:butcherbox/screens/home.dart';
import 'package:butcherbox/screens/orders.dart';
import 'package:butcherbox/screens/sign_in_page.dart';
import 'package:butcherbox/screens/sign_up.dart';
import 'package:butcherbox/screens/store_screen.dart';
import 'package:butcherbox/services/auth.dart';
import 'package:butcherbox/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (BuildContext context) => SignInPage()),
      //     (route) => false);
      Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(builder: (context) => new SignInPage()));
      //onSignOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final requestedSignout = await showAlertDialog(context,
        title: 'Logout',
        content: 'Are you sure you want to logout?',
        cancelActionText: 'Cancel',
        defaultActionText: 'Yes');
    if (requestedSignout == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[200],
        title: Text(
          'Account Settings',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green[900]),
        ),
      ),
      body: Container(
          child: Column(
        children: [
          SizedBox(height: 10),
          ListView(
            shrinkWrap: true,
            children: [
              AccountOptions(
                  enter: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/accountinfo');
                  },
                  headOption: 'Account Information',
                  subOption: 'Set Account preferences here',
                  iconPlace: Icons.account_circle),
              SizedBox(height: 5),
              // AccountOptions(
              //     enter: () {
              //       Navigator.of(context, rootNavigator: true)
              //           .pushNamed('/locations');
              //     },
              //     headOption: 'Locations',
              //     subOption: 'Add and remove addresses',
              //     iconPlace: Icons.location_on_rounded),
              // SizedBox(height: 5),
              AccountOptions(
                  enter: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/orders');
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => Provider<Database>(
                    //       builder: (context, child) => Orders(),
                    //       create: (context) => FireStoreDatabase(uid: user.uid),
                    //     ),
                    //   ),
                    // );
                  },
                  headOption: 'Orders',
                  subOption: 'List of all your orders',
                  iconPlace: Icons.my_library_books),
              SizedBox(height: 5),
              AccountOptions(
                  enter: () => _confirmSignOut(context),
                  headOption: 'Logout',
                  subOption: 'Sign out of app',
                  iconPlace: Icons.logout),
              AccountOptions(
                  enter: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/orders2');
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => Provider<Database>(
                    //       builder: (context, child) => Orders(),
                    //       create: (context) => FireStoreDatabase(uid: user.uid),
                    //     ),
                    //   ),
                    // );
                  },
                  headOption: 'Orders',
                  subOption: 'List of all your orders',
                  iconPlace: Icons.my_library_books),
              SizedBox(height: 5),
            ],
          ),
        ],
      )),
    );
  }
}
