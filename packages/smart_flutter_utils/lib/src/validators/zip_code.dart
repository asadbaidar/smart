import 'package:smart_flutter_utils/smart_flutter_utils.dart';

enum ZipCodeValidationError { empty, small }

class ZipCode extends FormsInput<String, ZipCodeValidationError> {
  const ZipCode.pure([super.value = '']) : super.pure();
  const ZipCode.dirty([super.value = '']) : super.dirty();

  @override
  ZipCodeValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return ZipCodeValidationError.empty;
    } else if (value.trim().length < 5) {
      return ZipCodeValidationError.small;
    } else {
      return null;
    }
  }
}

extension ZipCodeFromString on String {
  ZipCode toZipCode() => ZipCode.dirty(this);

  ZipCode toOptionalZipCode() =>
      isBlank ? trim().toPureZipCode() : trim().toZipCode();

  ZipCode toPureZipCode() => ZipCode.pure(this);
}
