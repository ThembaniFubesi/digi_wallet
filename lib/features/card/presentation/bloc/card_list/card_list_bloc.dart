import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/usecases/get_cards_usecase.dart';
import 'package:equatable/equatable.dart';

part 'card_list_event.dart';
part 'card_list_state.dart';

class CardListBloc extends Bloc<CardListEvent, CardListState> {
  final GetCardsUseCase _getCardsUseCase;

  CardListBloc(
    this._getCardsUseCase,
  ) : super(const CardListState(
            errorMessage: '', cards: [], status: CardListStatus.initial)) {
    on<LoadCardList>(_loadCardList);
    on<AddCard>(_addCard);
    on<UpdateCard>(_updateCard);
    on<RemoveCard>(_removeCard);
  }

  FutureOr<void> _loadCardList(
    LoadCardList event,
    Emitter<CardListState> emit,
  ) async {
    emit(state.copyWith(status: CardListStatus.loading));

    final response = await _getCardsUseCase();
    response.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message, status: CardListStatus.failed)),
      (cards) => emit(state.copyWith(cards: cards, status: CardListStatus.loaded)),
    );
  }

  FutureOr<void> _addCard(
    AddCard event,
    Emitter<CardListState> emit,
  ) {
    emit(
      state.copyWith(
        status: CardListStatus.loaded,
        cards: [...state.cards, event.payload],
      ),
    );
  }

  FutureOr<void> _updateCard(
    UpdateCard event,
    Emitter<CardListState> emit,
  ) {
    emit(
      state.copyWith(
        status: CardListStatus.loaded,
        cards: [
          ...state.cards.map((card) {
            return card.id == event.payload.id ? event.payload : card;
          })
        ],
      ),
    );
  }

  FutureOr<void> _removeCard(
    RemoveCard event,
    Emitter<CardListState> emit,
  ) {

    emit(
      state.copyWith(
        status: CardListStatus.loaded,
        cards: [...state.cards.where((card) => card.id != event.id)],
      ),
    );
  }
}
