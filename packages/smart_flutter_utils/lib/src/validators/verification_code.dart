import 'package:smart_flutter_utils/src/validators/validators.dart';

enum VerificationCodeValidationError { empty, small }

class VerificationCode
    extends FormsInput<String, VerificationCodeValidationError> {
  const VerificationCode.pure([super.value = '']) : super.pure();
  const VerificationCode.dirty([super.value = '']) : super.dirty();

  @override
  VerificationCodeValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return VerificationCodeValidationError.empty;
    } else if (value.trim().length < 5) {
      return VerificationCodeValidationError.small;
    } else {
      return null;
    }
  }
}

extension VerificationCodeFromString on String {
  VerificationCode toVerificationCode() => VerificationCode.dirty(this);

  VerificationCode toOptionalVerificationCode() {
    final text = trim();
    return text.isEmpty
        ? text.toPureVerificationCode()
        : text.toVerificationCode();
  }

  VerificationCode toPureVerificationCode() => VerificationCode.pure(this);
}

extension VerificationCodeFromStringNullable on String? {
  VerificationCode toVerificationCode([String fallback = '']) =>
      (this ?? fallback).toVerificationCode();

  VerificationCode toOptionalVerificationCode([String fallback = '']) =>
      (this ?? fallback).toOptionalVerificationCode();

  VerificationCode toPureVerificationCode([String fallback = '']) =>
      (this ?? fallback).toPureVerificationCode();
}
