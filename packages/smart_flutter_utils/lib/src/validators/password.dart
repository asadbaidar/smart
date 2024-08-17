import 'package:smart_flutter_utils/src/validators/validators.dart';

enum PasswordValidationError { empty, invalid, mismatch }

class Password extends FormsInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    final bool passwordValid = value.length >= 4 && value.length <= 16;
    if (value.trim().isEmpty) {
      return PasswordValidationError.empty;
    } else if (!passwordValid) {
      return PasswordValidationError.invalid;
    } else {
      return null;
    }
  }
}

class ConfirmPassword extends FormsInput<String, PasswordValidationError> {
  const ConfirmPassword.pure([this.matcher]) : super.pure('');
  const ConfirmPassword.dirty([super.value = '', this.matcher]) : super.dirty();

  final String? matcher;

  @override
  PasswordValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.trim() != matcher) {
      return PasswordValidationError.mismatch;
    } else {
      return null;
    }
  }
}
