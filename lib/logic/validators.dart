abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidators {
  final StringValidator mailValidator = NonEmptyStringValidator();
  final StringValidator passValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can not be empty';
  final String invalidPasswordErrorText = 'Password can not be empty';
}
