import 'package:smart_flutter_utils/src/validators/validators.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormsInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    final bool emailValid = value.isEmail;
    if (value.trim().isEmpty) {
      return EmailValidationError.empty;
    } else if (!emailValid) {
      return EmailValidationError.invalid;
    } else {
      return null;
    }
  }
}

extension EmailValidity on String {
  bool get isEmail => RegExp(
        r'^[a-zA-Z0-9.\+\-]+@[a-zA-Z0-9.\+\-]+\.[a-zA-Z]+$',
      ).hasMatch(trim());
}
