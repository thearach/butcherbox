import 'dart:io';
import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/butch_widgets/showAlertDialog.dart';
import 'package:butcherbox/butch_widgets/showExceptionAlertDialog.dart';
import 'package:butcherbox/logic/validators.dart';
import 'package:butcherbox/models/emailSignInModel.dart';
import 'package:butcherbox/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget with EmailAndPasswordValidators {
  // SignUp({@required this.auth});
  // final AuthBase auth;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _mailControl = TextEditingController();
  final TextEditingController _passControl = TextEditingController();

  final FocusNode _mailNode = FocusNode();
  final FocusNode _passNode = FocusNode();

  bool _submitted = false;
  bool _isLoading = false;

  String get _mailText => _mailControl.text;
  String get _passText => _passControl.text;

  EmailFormType _formType = EmailFormType.register;

  @override
  void dispose() {
    _mailControl.dispose();
    _passControl.dispose();
    _mailNode.dispose();
    _passNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailFormType.signIn) {
        await auth.signInWithEmailAndPassword(_mailText, _passText);
      } else {
        await auth.createUserWithEmailAndPassword(_mailText, _passText);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Some Error Occurred',
        exception: e,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _mailEditComplete() {
    final newFocus =
        widget.mailValidator.isValid(_mailText) ? _passNode : _mailNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleForm() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailFormType.register
          ? EmailFormType.signIn
          : EmailFormType.register;
    });
    _mailControl.clear();
    _passControl.clear();
  }

  @override
  Widget build(BuildContext context) {
    // final isLoading = Provider.of<ValueNotifier<bool>>(context);
    //final SignInBloc bloc = SignInBloc(auth: auth, isLoading: isLoading);

    final mainText =
        _formType == EmailFormType.register ? 'CREATE AN ACCOUNT' : 'SIGN IN';

    final otherText = _formType == EmailFormType.register
        ? 'Have an Account? Sign In'
        : 'Create an Account. Sign Up';

    bool submitEnabled = widget.mailValidator.isValid(_mailText) &&
        widget.passValidator.isValid(_passText) &&
        !_isLoading;

    bool showMailErrorText =
        _submitted && !widget.mailValidator.isValid(_mailText);
    bool showErrorText = _submitted && !widget.passValidator.isValid(_passText);

    void _updateState;
    {
      setState(() {
        print('email: $_mailText, password: $_passText');
      });
    }

// Widget _buildContent(BuildContext context) { remember to put this back later if rearranging does not work
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset('images/greenlogoback.png'),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/backg.jpg'),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        //remember to put this back in the sized box -- child: _buildHeader()
                        Text(
                          'SIGN UP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _mailControl,
                          focusNode: _mailNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _mailEditComplete,
                          onChanged: (email) => _updateState,
                          enabled: _isLoading = false,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              errorText: showMailErrorText
                                  ? widget.invalidEmailErrorText
                                  : null,
                              icon: Icon(
                                Icons.account_circle,
                                color: Colors.white,
                              ),
                              hintText: 'Enter Username'),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _passControl,
                          focusNode: _passNode,
                          obscureText: true,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          enabled: _isLoading = false,
                          onChanged: (password) => _updateState,
                          onEditingComplete: _submit,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              errorText: showErrorText
                                  ? widget.invalidPasswordErrorText
                                  : null,
                              icon: Icon(Icons.remove_red_eye,
                                  color: Colors.white),
                              hintText: 'Password'),
                        ),
                        SizedBox(height: 10.0),
                        ButcherButtons(
                          buttonText: mainText,
                          onPressed: () {
                            submitEnabled ? _submit : null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          height: 20.0,
                          color: Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   'Already have an account?',
                              //   style: TextStyle(
                              //     fontSize: 16.0,
                              //     color: Colors.white,
                              //   ),
                              // ),
                              SizedBox(width: 10.0),
                              FlatButton(
                                  onPressed: () {
                                    !_isLoading ? _toggleForm : null;
                                  },
                                  child: Text(
                                    otherText,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.0),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
    //}

    /* Widget _buildHeader() {
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
  }*/
  }
}
