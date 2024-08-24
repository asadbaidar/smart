import 'package:smart_flutter_utils/src/validators/validators.dart';

enum PhoneNumberValidationError { empty, invalid }

class PhoneNumber extends FormsInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure([super.value = '']) : super.pure();
  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  @override
  PhoneNumberValidationError? validator(String value) {
    final bool phoneNoValid =
        RegExp(r'^(\+){0,1}([0-9]){0,5}(?:[0-9]\x20?){6,9}[0-9]$')
            .hasMatch(value.trim());
    if (value.trim().isEmpty) {
      return PhoneNumberValidationError.empty;
    } else if (!phoneNoValid) {
      return PhoneNumberValidationError.invalid;
    } else {
      return null;
    }
  }
}

class USPhoneNumber extends FormsInput<String, PhoneNumberValidationError> {
  const USPhoneNumber.pure([super.value = '']) : super.pure();
  const USPhoneNumber.dirty([super.value = '']) : super.dirty();

  @override
  PhoneNumberValidationError? validator(String value) {
    final bool phoneNoValid =
        RegExp(r'^(\+1)(?:[0-9]\x20?){6,9}[0-9]$').hasMatch(value.trim());
    if (value.trim().isEmpty) {
      return PhoneNumberValidationError.empty;
    } else if (!phoneNoValid) {
      return PhoneNumberValidationError.invalid;
    } else {
      return null;
    }
  }
}

extension PhoneNumberFromString on String {
  PhoneNumber toPhoneNumber() => PhoneNumber.dirty(this);

  PhoneNumber toOptionalPhoneNumber() {
    final text = trim();
    return text.isEmpty ? text.toPurePhoneNumber() : text.toPhoneNumber();
  }

  PhoneNumber toPurePhoneNumber() => PhoneNumber.pure(this);
}

extension USPhoneNumberFromString on String {
  USPhoneNumber toUSPhoneNumber() => USPhoneNumber.dirty(this);

  USPhoneNumber toOptionalUSPhoneNumber() {
    final text = trim();
    return text.isEmpty ? text.toPureUSPhoneNumber() : text.toUSPhoneNumber();
  }

  USPhoneNumber toPureUSPhoneNumber() => USPhoneNumber.pure(this);
}

extension PhoneNumberFromStringNullable on String? {
  PhoneNumber toPhoneNumber([String fallback = '']) =>
      (this ?? fallback).toPhoneNumber();

  PhoneNumber toOptionalPhoneNumber([String fallback = '']) =>
      (this ?? fallback).toOptionalPhoneNumber();

  PhoneNumber toPurePhoneNumber([String fallback = '']) =>
      (this ?? fallback).toPurePhoneNumber();
}

extension USPhoneNumberFromStringNullable on String? {
  USPhoneNumber toUSPhoneNumber([String fallback = '']) =>
      (this ?? fallback).toUSPhoneNumber();

  USPhoneNumber toOptionalUSPhoneNumber([String fallback = '']) =>
      (this ?? fallback).toOptionalUSPhoneNumber();

  USPhoneNumber toPureUSPhoneNumber([String fallback = '']) =>
      (this ?? fallback).toPureUSPhoneNumber();
}
