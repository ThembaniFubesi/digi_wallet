import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:digi_wallet/core/validators/banned_country_validator.dart';
import 'package:digi_wallet/core/validators/card_exists_validator.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/usecases/update_card_usecase.dart';
import 'package:equatable/equatable.dart';

part 'update_card_event.dart';
part 'update_card_state.dart';

class UpdateCardBloc extends Bloc<UpdateCardEvent, UpdateCardState> {
  final UpdateCardUseCase _updateCardUseCase;
  final BannedCountryValidator _bannedCountryValidator;
  final CardExistsValidator _cardExistsValidator;
  UpdateCardBloc(this._updateCardUseCase, this._bannedCountryValidator,
      this._cardExistsValidator)
      : super(UpdateCardInitial()) {
    on<UpdateCard>(_updateCard);
  }

  FutureOr<void> _updateCard(
    UpdateCard event,
    Emitter<UpdateCardState> emit,
  ) async {
    emit(UpdateCardLoading());

    final isBannedCountry =
        await _bannedCountryValidator.validate(event.card.issuingCountry);
    if (isBannedCountry != null) {
      emit(UpdateCardFailure(errorMessage: isBannedCountry));
      return;
    }

    if (event.isCardNumberChanged) {
      final cardExists =
          await _cardExistsValidator.validate(event.card.cardNumber);
      if (cardExists != null) {
        emit(UpdateCardFailure(errorMessage: cardExists));
        return;
      }
    }

    final card = await _updateCardUseCase(event.card);

    emit(UpdateCardSuccess(card: card));
  }
}
