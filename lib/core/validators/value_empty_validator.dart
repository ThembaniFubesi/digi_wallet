import 'package:digi_wallet/core/validators/validator.dart';

class ValueEmptyValidator extends Validator {
  ValueEmptyValidator({super.message});

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }
}
