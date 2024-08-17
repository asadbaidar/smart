import 'package:smart_flutter_utils/src/validators/validators.dart';

enum FormInputError { empty }

class FormInput<T> extends FormsInput<T?, FormInputError> {
  const FormInput.pure([super.value]) : super.pure();
  const FormInput.dirty([super.value]) : super.dirty();

  @override
  FormInputError? validator(T? value) {
    return value == null || (value is List && value.isEmpty)
        ? FormInputError.empty
        : null;
  }

  bool get isEmpty => validator(value) == FormInputError.empty;

  bool get isNotEmpty => !isEmpty;
}

extension FormInputFrom<T> on T {
  FormInput<T> toFormInput() => FormInput<T>.dirty(this);

  FormInput<T> toOptionalFormInput() =>
      this == null ? toPureFormInput() : toFormInput();

  FormInput<T> toPureFormInput() => FormInput<T>.pure(this);
}
