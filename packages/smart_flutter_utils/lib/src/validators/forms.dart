import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

export 'package:formz/formz.dart';

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

  static FormzStatus validate({
    bool requiredPure = false,
    required List<FormzInput<dynamic, dynamic>> required,
    List<FormzInput<dynamic, dynamic>> optional = const [],
  }) {
    final requiredStatus = Forms.valid(required);
    final optionalStatus =
        optional.isEmpty ? FormzStatus.pure : Forms.validOrPure(optional);
    final isOptionalDirty = optional.any((input) => input.dirty);
    return requiredStatus.isPure && optionalStatus.isPure
        ? FormzStatus.pure
        : (requiredStatus.isValid || (requiredPure && requiredStatus.isPure)) &&
                (optionalStatus.isValid ||
                    optionalStatus.isPure ||
                    isOptionalDirty)
            ? FormzStatus.valid
            : FormzStatus.invalid;
  }

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

abstract class FormsInput<T, E> extends FormzInput<T, E> with EquatableMixin {
  /// Constructor which create a `pure` [FormzInput] with a given value.
  const FormsInput.pure(super.value) : super.pure();

  /// Constructor which create a `dirty` [FormzInput] with a given value.
  const FormsInput.dirty(super.value) : super.dirty();

  @override
  List<Object?> get props => [value, pure, ...extraProps];

  List<Object?> get extraProps => [];
}

extension FormInputValidity<T, E> on FormzInput<T, E> {
  bool get validOrPure => pure || valid;
  bool get dirty => !pure;
}
