import 'dart:async';

import 'package:digi_wallet/core/validators/validator.dart';
import 'package:digi_wallet/features/card/domain/usecases/get_card_by_card_number_usecase.dart';

class CardExistsValidator extends Validator {
  final GetCardByCardNumberUseCase _getCardByCardNumberUseCase;

  CardExistsValidator({
    super.message,
    required GetCardByCardNumberUseCase getCardByCardNumberUseCase,
  }) : _getCardByCardNumberUseCase = getCardByCardNumberUseCase;

  @override
  FutureOr<String?> validate(String? value) async {
    if (value == null) {
      return null;
    }
    final cardResult = await _getCardByCardNumberUseCase(value);
    return cardResult.fold((failure) => null, (r) => 'The card is already added');
  }
}
