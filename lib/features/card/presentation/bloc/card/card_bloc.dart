import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/usecases/get_single_card_usecase.dart';
import 'package:equatable/equatable.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final GetSingleCardUseCase _singleCardUseCase;
  CardBloc(this._singleCardUseCase) : super(CardInitial()) {
    on<LoadCard>(_load);
  }

  FutureOr<void> _load(
    LoadCard event,
    Emitter<CardState> emit,
  ) async {
    emit(CardLoading());

    final response = await _singleCardUseCase(event.id);

    response.fold(
      (failure) => emit(CardFailure(errorMessage: failure.message)),
      (card) => emit(CardLoaded(
        card: card,
      )),
    );
  }
}
