import 'package:smart_flutter_utils/src/validators/validators.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormsInput<String, EmailValidationError> {
  const Email.pure([super.value = '']) : super.pure();
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

extension EmailFromString on String {
  Email toEmail() => Email.dirty(this);

  Email toOptionalEmail() {
    final text = trim();
    return text.isEmpty ? text.toPureEmail() : text.toEmail();
  }

  Email toPureEmail() => Email.pure(this);
}

extension EmailFromStringNullable on String? {
  Email toEmail([String fallback = '']) => (this ?? fallback).toEmail();

  Email toOptionalEmail([String fallback = '']) =>
      (this ?? fallback).toOptionalEmail();

  Email toPureEmail([String fallback = '']) => (this ?? fallback).toPureEmail();
}
