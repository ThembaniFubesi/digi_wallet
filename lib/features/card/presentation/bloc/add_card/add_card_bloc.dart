import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:digi_wallet/core/validators/banned_country_validator.dart';
import 'package:digi_wallet/core/validators/card_exists_validator.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/usecases/create_card_usecase.dart';
import 'package:equatable/equatable.dart';

part 'add_card_event.dart';
part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  final CreateCardUseCase _createCardUseCase;
  final BannedCountryValidator _bannedCountryValidator;
  final CardExistsValidator _cardExistsValidator;

  AddCardBloc(this._createCardUseCase, this._bannedCountryValidator, this._cardExistsValidator)
      : super(AddCardInitial()) {
    on<AddCard>(_addCard);
  }

  FutureOr<void> _addCard(
    AddCard event,
    Emitter<AddCardState> emit,
  ) async {
    emit(AddCardLoading());

    final isBannedCountry =
        await _bannedCountryValidator.validate(event.payload.issuingCountry);
    if (isBannedCountry != null) {
      emit(AddCardFailure(errorMessage: isBannedCountry));
      return;
    }

    final cardExists = await _cardExistsValidator.validate(event.payload.cardNumber);
    if (cardExists != null) {
      emit(AddCardFailure(errorMessage: cardExists));
      return;
    }


    final savedCard = await _createCardUseCase(event.payload);
    emit(AddCardSuccess(card: savedCard));
  }
}
