import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/butch_widgets/showExceptionAlertDialog.dart';
import 'package:butcherbox/logic/emailSignInBloc.dart';
import 'package:butcherbox/models/emailSignInModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class EmailSignInFormBloc extends StatefulWidget {
  EmailSignInFormBloc({@required this.bloc});

  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBloc(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlocState createState() => _EmailSignInFormBlocState();
}

class _EmailSignInFormBlocState extends State<EmailSignInFormBloc> {
  final TextEditingController _mailControl = TextEditingController();
  final TextEditingController _passControl = TextEditingController();

  final FocusNode _mailNode = FocusNode();
  final FocusNode _passNode = FocusNode();

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
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Some Error Occurred',
        exception: e,
      );
    }
  }

  void _mailEditComplete(EmailSignInModel model) {
    final newFocus =
        model.mailValidator.isValid(model.email) ? _passNode : _mailNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleForm() {
    widget.bloc.toggleFormType();
    _mailControl.clear();
    _passControl.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      SizedBox(height: 20.0),
      _emailField(model),
      SizedBox(height: 20.0),
      _passField(model),
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

  TextField _emailField(EmailSignInModel model) {
    return TextField(
      controller: _mailControl,
      focusNode: _mailNode,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _mailEditComplete(model),
      onChanged: widget.bloc.updateEmail,
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

  TextField _passField(EmailSignInModel model) {
    return TextField(
      controller: _passControl,
      focusNode: _passNode,
      obscureText: true,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      enabled: model.isLoading == false,
      onChanged: widget.bloc.updatePassword,
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
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model),
            ),
          );
        });
  }
}
