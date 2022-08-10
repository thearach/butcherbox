import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/butch_widgets/showExceptionAlertDialog.dart';
import 'package:butcherbox/models/emailSignInChangeModel.dart';
import 'package:butcherbox/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class EmailSignInFormChange extends StatefulWidget {
  EmailSignInFormChange({@required this.model});

  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInFormChange(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormChangeState createState() => _EmailSignInFormChangeState();
}

class _EmailSignInFormChangeState extends State<EmailSignInFormChange> {
  final TextEditingController _mailControl = TextEditingController();
  final TextEditingController _passControl = TextEditingController();

  final FocusNode _mailNode = FocusNode();
  final FocusNode _passNode = FocusNode();

  EmailSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    _mailControl.dispose();
    _passControl.dispose();
    _mailNode.dispose();
    _passNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await model.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Some Error Occurred',
        exception: e,
      );
    }
  }

  void _mailEditComplete() {
    final newFocus =
        model.mailValidator.isValid(model.email) ? _passNode : _mailNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleForm() {
    model.toggleFormType();
    _mailControl.clear();
    _passControl.clear();
  }

  List<Widget> _buildChildren() {
    return [
      SizedBox(height: 20.0),
      _emailField(),
      SizedBox(height: 20.0),
      _passField(),
      SizedBox(height: 10.0),
      ButcherButtons(
          buttonText: model.mainButtonText,
          onPressed: model.canSubmit ? _submit : null),
      SizedBox(height: 10.0),
      Container(
        height: 20.0,
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10.0),
            FlatButton(
                onPressed: !model.isLoading ? _toggleForm : null,
                child: Text(
                  model.guideText,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ))
          ],
        ),
      )
    ];
  }

  // final isLoading = Provider.of<ValueNotifier<bool>>(context);
  //final SignInBloc bloc = SignInBloc(auth: auth, isLoading: isLoading);

  TextField _emailField() {
    return TextField(
      controller: _mailControl,
      focusNode: _mailNode,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _mailEditComplete(),
      onChanged: model.updateEmail,
      enabled: model.isLoading == false,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          errorText: model.mailErrorText,
          icon: Icon(
            Icons.account_circle,
            color: Colors.white,
          ),
          hintText: 'Enter Username'),
    );
  }

  TextField _passField() {
    return TextField(
      controller: _passControl,
      focusNode: _passNode,
      obscureText: true,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      enabled: model.isLoading == false,
      onChanged: model.updatePassword,
      onEditingComplete: _submit,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          errorText: model.passErrorText,
          icon: Icon(Icons.remove_red_eye, color: Colors.white),
          hintText: 'Password'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
