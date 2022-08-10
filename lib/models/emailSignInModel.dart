import 'package:butcherbox/logic/validators.dart';

enum EmailFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel(
      {this.email = '',
      this.password = '',
      this.formType = EmailFormType.register,
      this.isLoading = false,
      this.submitted = false});

  final String email;
  final String password;
  final EmailFormType formType;
  final bool isLoading;
  final bool submitted;

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

  bool get canSubmit {
    return mailValidator.isValid(email) &&
        passValidator.isValid(password) &&
        !isLoading;
  }

  EmailSignInModel copyWith(
      {String email,
      String password,
      EmailFormType formType,
      bool isLoading,
      bool submitted}) {
    return EmailSignInModel(
        email: email ?? this.email,
        password: password ?? this.password,
        formType: formType ?? this.formType,
        isLoading: isLoading ?? this.isLoading,
        submitted: submitted ?? this.submitted);
  }
  //model.copyWith(email: email)
}
