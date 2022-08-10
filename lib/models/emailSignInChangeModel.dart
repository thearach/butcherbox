import 'package:butcherbox/logic/validators.dart';
import 'package:butcherbox/models/emailSignInModel.dart';
import 'package:butcherbox/services/auth.dart';
import 'package:flutter/foundation.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel(
      {@required this.auth,
      this.email = '',
      this.password = '',
      this.formType = EmailFormType.register,
      this.isLoading = false,
      this.submitted = false});

  final AuthBase auth;
  String email;
  String password;
  EmailFormType formType;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get mainButtonText {
    return formType == EmailFormType.register ? 'CREATE AN ACCOUNT' : 'SIGN IN';
  }

  String get guideText {
    return formType == EmailFormType.register
        ? 'Have an Account? Sign In'
        : 'Create an Account. Sign Up';
  }

  String get mailErrorText {
    bool showMailErrorText = submitted && !mailValidator.isValid(email);
    return showMailErrorText ? invalidEmailErrorText : null;
  }

  String get passErrorText {
    bool showPassErrorText = submitted && !passValidator.isValid(password);
    return showPassErrorText ? invalidPasswordErrorText : null;
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void toggleFormType() {
    final formType = this.formType == EmailFormType.register
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

  bool get canSubmit {
    return mailValidator.isValid(email) &&
        passValidator.isValid(password) &&
        !isLoading;
  }

  void updateWith(
      {String email,
      String password,
      EmailFormType formType,
      bool isLoading,
      bool submitted}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
