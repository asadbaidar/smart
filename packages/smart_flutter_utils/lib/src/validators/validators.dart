import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';

export 'package:formz/formz.dart';

export 'email.dart';
export 'file.dart';
export 'form_input.dart';
export 'password.dart';
export 'phone_number.dart';
export 'positive_int.dart';
export 'text_input.dart';
export 'verification_code.dart';
export 'zip_code.dart';

abstract class FormsInput<T, E> extends FormzInput<T, E> with EquatableMixin {
  /// Constructor which create a `pure` [FormzInput] with a given value.
  const FormsInput.pure(super.value) : super.pure();

  /// Constructor which create a `dirty` [FormzInput] with a given value.
  const FormsInput.dirty(super.value) : super.dirty();

  @override
  List<Object?> get props => [value, pure, ...extraProps];

  List<Object?> get extraProps => [];
}

class Forms {
  const Forms._();

  static FormzStatus valid(List<FormzInput<dynamic, dynamic>> inputs) =>
      inputs.every((element) => element.pure)
          ? FormzStatus.pure
          : inputs.any((input) => input.valid == false)
              ? FormzStatus.invalid
              : FormzStatus.valid;

  static FormzStatus validOrPure(List<FormzInput<dynamic, dynamic>> inputs) =>
      inputs.every((element) => element.pure)
          ? FormzStatus.pure
          : inputs.every((input) => input.valid || input.pure)
              ? FormzStatus.valid
              : FormzStatus.invalid;

  /// Only allow alphabets without spaces
  static final noSpacesFormatter =
      FilteringTextInputFormatter.deny(RegExp(r'\s\b|\b\s'));

  /// Only allow digits and + without spaces
  static final phoneNumberFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'^[0-9+]*$'));

  /// Only allow single spaces
  static final singleSpaceFormatter = FilteringTextInputFormatter.deny(
    RegExp(r'(\s){2,}$'),
    replacementString: ' ',
  );

  /// No spaces allowed
  static final noSpaceFormatter =
      FilteringTextInputFormatter.deny(RegExp(r'^(\s*)'));

  /// Only allow spaces between words
  static final List<TextInputFormatter> notEmptyFormatters = [
    noSpaceFormatter,
    singleSpaceFormatter,
  ];
}

extension FormInputValidity<T, E> on FormzInput<T, E> {
  bool get validOrPure => pure || valid;
  bool get dirty => !pure;
}
