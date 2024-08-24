import 'package:smart_flutter_utils/src/validators/validators.dart';
import 'package:smart_http/smart_http.dart';

enum FormFileValidationError { empty, limitExceeded }

class FormFile extends FormsInput<HttpFile?, FormFileValidationError> {
  const FormFile.pure([super.value])
      : loading = false,
        super.pure();

  const FormFile.dirty([super.value])
      : loading = false,
        super.dirty();

  const FormFile.toPure({HttpFile? value, this.loading = false})
      : super.pure(value);

  const FormFile.toDirty({HttpFile? value, this.loading = false})
      : super.dirty(value);

  final bool loading;

  FormFile copyWith({
    HttpFile? value,
    bool? loading,
    bool? pure,
  }) =>
      pure ?? this.pure
          ? FormFile.toPure(
              value: value ?? this.value,
              loading: loading ?? this.loading,
            )
          : FormFile.toDirty(
              value: value ?? this.value,
              loading: loading ?? this.loading,
            );

  FormFile toLoading({HttpFile? value, bool? pure}) => copyWith(
        loading: true,
        value: value ?? this.value,
        pure: pure ?? this.pure,
      );

  FormFile toPure({HttpFile? value, bool? loading}) => copyWith(
        pure: true,
        loading: loading ?? this.loading,
        value: value ?? this.value,
      );

  @override
  List<Object?> get extraProps => [loading];

  @override
  FormFileValidationError? validator(HttpFile? value) {
    return value == null
        ? FormFileValidationError.empty
        : value.isOver6MB
            ? FormFileValidationError.limitExceeded
            : null;
  }

  bool get isLoading => loading;

  bool get isNotLoading => !isLoading;

  bool get isEmpty => error == FormFileValidationError.empty;

  bool get isNotEmpty => !isEmpty;

  bool get isLimitExceeded => error == FormFileValidationError.limitExceeded;

  bool get isLimitNotExceeded => !isLimitExceeded;

  String? get errorMessage {
    switch (error) {
      case FormFileValidationError.empty:
        return 'Please select a file';
      case FormFileValidationError.limitExceeded:
        return 'File size must be under 6MB';
      default:
        return null;
    }
  }
}

extension FormFileFromHttpFile on HttpFile {
  FormFile toFormFile() => FormFile.dirty(this);
  FormFile toPureFormFile() => FormFile.pure(this);
}

extension FormFileFromHttpFileNullable on HttpFile? {
  FormFile toFormFile([HttpFile? fallback]) => (this ?? fallback).toFormFile();
  
  FormFile toPureFormFile([HttpFile? fallback]) =>
      (this ?? fallback).toPureFormFile();
}
