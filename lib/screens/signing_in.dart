import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/butch_widgets/showExceptionAlertDialog.dart';
import 'package:butcherbox/logic/emailSignInBloc.dart';
import 'package:butcherbox/logic/sign_in_bloc.dart';
import 'package:butcherbox/screens/emailSignInPage.dart';
import 'package:butcherbox/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SigningIn extends StatelessWidget {
  const SigningIn({Key key, @required this.bloc, @required this.isLoading})
      : super(key: key);
  final SignInBloc bloc;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInBloc>(
          create: (_) => SignInBloc(auth: auth, isLoading: isLoading),
          child: Consumer<SignInBloc>(
            builder: (_, bloc, __) => SigningIn(
              bloc: bloc,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(context,
        title: 'Sign In Failed', exception: exception);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      _showSignInError(context, e);
      print(e.message);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
      //print('${userCredentials.user.uid}');
      //final userCredentials = await auth.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      _showSignInError(context, e);
      print(e.message);
    }
  }

  // Future<void> _signInWithEmailAndPassword(BuildContext context) async {
  //   try {
  //     await bloc.si();
  //     //print('${userCredentials.user.uid}');
  //     //final userCredentials = await auth.signInWithGoogle();
  //   } on FirebaseAuthException catch (e) {
  //     _showSignInError(context, e);
  //     print(e.message);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final isLoading = Provider.of<ValueNotifier<bool>>(context);
    return SafeArea(
      top: true,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/backg.jpg'),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //SizedBox(height: 24.0, child: Container(color: Colors.white)),
            Image.asset('images/greenlogoback.png'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  // SizedBox(height: 10.0),
                  SizedBox(height: 25.0, child: _buildHeader()),
                  /*Text(
                              'SIGN IN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),*/
                  EmailSignInPage(),
                  // ButcherButtons(
                  //     buttonText: 'SIGN IN Anonymously',
                  //     onPressed: isLoading
                  //         ? null
                  //         : () => _signInAnonymously(context)),
                  SizedBox(height: 20.0),

                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: EdgeInsets.fromLTRB(64.0, 8.0, 16.0, 8.0)),
                        onPressed:
                            isLoading ? null : () => _signInWithGoogle(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('images/google-logo.png'),
                            Text(
                              'Sign in with Google',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16.0),
                            )
                          ],
                        )),
                  ),
                  SizedBox(height: 80.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'SIGN IN',
      style: TextStyle(
          color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
    );
  }
}
