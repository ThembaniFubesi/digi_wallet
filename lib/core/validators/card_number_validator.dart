import 'package:digi_wallet/core/validators/validator.dart';

class CardNumberValidator extends Validator {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the card number';
    }
    if (value.length < 12) {
      return 'card number cannot be less than 12 digits';
    }
    return null;
  }
}
