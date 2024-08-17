
import 'package:smart_flutter_utils/src/validators/validators.dart';

enum VerificationCodeValidationError { empty, small }

class VerificationCode
    extends FormsInput<String, VerificationCodeValidationError> {
  const VerificationCode.pure() : super.pure('');
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
