import 'dart:async';

import 'package:butcherbox/models/emailSignInModel.dart';
import 'package:butcherbox/services/auth.dart';
import 'package:flutter/foundation.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void toggleFormType() {
    final formType = _model.formType == EmailFormType.register
        ? EmailFormType.signIn
        : EmailFormType.register;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateWith(
      {String email,
      String password,
      EmailFormType formType,
      bool isLoading,
      bool submitted}) {
    //update model
    //add updated model to _modelController
    _model = _model.copyWith(
        email: email,
        password: password,
        formType: formType,
        isLoading: isLoading,
        submitted: submitted);
    _modelController.add(_model);
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.formType == EmailFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }
}
