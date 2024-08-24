import 'package:smart_flutter_utils/src/validators/validators.dart';

enum PositiveIntValidationError { negative }

class PositiveInt extends FormsInput<String, PositiveIntValidationError> {
  const PositiveInt.pure([super.value = '']) : super.pure();
  const PositiveInt.dirty([super.value = '']) : super.dirty();

  @override
  PositiveIntValidationError? validator(String value) {
    return (int.tryParse(value) ?? -1) < 0
        ? PositiveIntValidationError.negative
        : null;
  }
}

class PositiveIntOptonal
    extends FormsInput<String, PositiveIntValidationError> {
  const PositiveIntOptonal.pure([super.value = '']) : super.pure();
  const PositiveIntOptonal.dirty([super.value = '']) : super.dirty();

  @override
  PositiveIntValidationError? validator(String value) {
    return value.isEmpty
        ? null
        : (int.tryParse(value) ?? -1) < 0
            ? PositiveIntValidationError.negative
            : null;
  }
}

extension PositiveIntFromString on String {
  PositiveInt toPositiveInt() => PositiveInt.dirty(this);

  PositiveInt toPurePositiveInt() => PositiveInt.pure(this);

  PositiveIntOptonal toPositiveIntOptional() => PositiveIntOptonal.dirty(this);

  PositiveIntOptonal toPurePositiveIntOptional() =>
      PositiveIntOptonal.pure(this);
}

extension PositiveIntFromStringNullable on String? {
  PositiveInt toPositiveInt([String fallback = '']) =>
      (this ?? fallback).toPositiveInt();

  PositiveInt toPurePositiveInt([String fallback = '']) =>
      (this ?? fallback).toPurePositiveInt();

  PositiveIntOptonal toPositiveIntOptional([String fallback = '']) =>
      (this ?? fallback).toPositiveIntOptional();

  PositiveIntOptonal toPurePositiveIntOptional([String fallback = '']) =>
      (this ?? fallback).toPurePositiveIntOptional();
}

extension PositiveIntFromInt on int {
  PositiveInt toPositiveInt() => toString().toPositiveInt();

  PositiveInt toPurePositiveInt() => toString().toPurePositiveInt();

  PositiveIntOptonal toPositiveIntOptional() =>
      toString().toPositiveIntOptional();

  PositiveIntOptonal toPurePositiveIntOptional() =>
      toString().toPurePositiveIntOptional();
}

extension PositiveIntFromIntNullable on int? {
  PositiveInt toPositiveInt([int fallback = 0]) =>
      (this ?? fallback).toPositiveInt();

  PositiveInt toPurePositiveInt([int fallback = 0]) =>
      (this ?? fallback).toPurePositiveInt();

  PositiveIntOptonal toPositiveIntOptional([int fallback = 0]) =>
      (this ?? fallback).toPositiveIntOptional();

  PositiveIntOptonal toPurePositiveIntOptional([int fallback = 0]) =>
      (this ?? fallback).toPurePositiveIntOptional();
}
