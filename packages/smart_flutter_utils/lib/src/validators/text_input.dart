import 'package:smart_flutter_utils/src/validators/validators.dart';

enum TextInputValidationError { empty }

class TextInput extends FormsInput<String, TextInputValidationError> {
  const TextInput.pure([super.value = '']) : super.pure();
  const TextInput.dirty([super.value = '']) : super.dirty();

  @override
  TextInputValidationError? validator(String value) {
    return value.trim().isEmpty ? TextInputValidationError.empty : null;
  }

  bool get isEmpty => error == TextInputValidationError.empty;

  bool get isNotEmpty => !isEmpty;
}

extension TextInputFromString on String {
  TextInput toTextInput() => TextInput.dirty(this);

  TextInput toOptionalTextInput() {
    final text = trim();
    return text.isEmpty ? text.toPureTextInput() : text.toTextInput();
  }

  TextInput toPureTextInput() => TextInput.pure(this);
}

extension TextInputFromStringNullable on String? {
  TextInput toTextInput([String fallback = '']) =>
      (this ?? fallback).toTextInput();

  TextInput toOptionalTextInput([String fallback = '']) =>
      (this ?? fallback).toOptionalTextInput();

  TextInput toPureTextInput([String fallback = '']) =>
      (this ?? fallback).toPureTextInput();
}
