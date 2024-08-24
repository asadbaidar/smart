import 'package:smart_flutter_utils/src/validators/validators.dart';

enum PasswordValidationError { empty, invalid, mismatch }

class Password extends FormsInput<String, PasswordValidationError> {
  const Password.pure([super.value = '']) : super.pure();
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
  const ConfirmPassword.pure([this.matcher, super.value = '']) : super.pure();
  const ConfirmPassword.dirty([this.matcher, super.value = '']) : super.dirty();

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

extension PasswordFromString on String {
  Password toPassword() => Password.dirty(this);

  Password toOptionalPassword() {
    final text = trim();
    return text.isEmpty ? text.toPurePassword() : text.toPassword();
  }

  Password toPurePassword() => Password.pure(this);
}

extension ConfirmPasswordFromString on String {
  ConfirmPassword toConfirmPassword([String? matcher]) =>
      ConfirmPassword.dirty(matcher, this);

  ConfirmPassword toOptionalConfirmPassword([String? matcher]) {
    final text = trim();
    return text.isEmpty
        ? text.toPureConfirmPassword(matcher)
        : text.toConfirmPassword(matcher);
  }

  ConfirmPassword toPureConfirmPassword([String? matcher]) =>
      ConfirmPassword.pure(matcher, this);
}

extension PasswordFromStringNullable on String? {
  Password toPassword([String fallback = '']) =>
      (this ?? fallback).toPassword();

  Password toOptionalPassword([String fallback = '']) =>
      (this ?? fallback).toOptionalPassword();

  Password toPurePassword([String fallback = '']) =>
      (this ?? fallback).toPurePassword();
}

extension ConfirmPasswordFromStringNullable on String? {
  ConfirmPassword toConfirmPassword([String? matcher, String fallback = '']) =>
      (this ?? fallback).toConfirmPassword(matcher);

  ConfirmPassword toOptionalConfirmPassword(
          [String? matcher, String fallback = '']) =>
      (this ?? fallback).toOptionalConfirmPassword(matcher);

  ConfirmPassword toPureConfirmPassword(
          [String? matcher, String fallback = '']) =>
      (this ?? fallback).toPureConfirmPassword(matcher);
}
