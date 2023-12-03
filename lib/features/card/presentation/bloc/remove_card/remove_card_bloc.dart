import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:digi_wallet/features/card/domain/usecases/remove_card_usecase.dart';
import 'package:equatable/equatable.dart';

part 'remove_card_event.dart';
part 'remove_card_state.dart';

class RemoveCardBloc extends Bloc<RemoveCardEvent, RemoveCardState> {
  final RemoveCardUseCase _removeCardUseCase;
  RemoveCardBloc(this._removeCardUseCase) : super(RemoveCardInitial()) {
    on<RemoveCard>(_removeCard);
  }

  FutureOr<void> _removeCard(
    RemoveCard event,
    Emitter<RemoveCardState> emit,
  ) async {
    emit(RemoveCardLoading());

    await _removeCardUseCase(event.id);

    emit(RemoveCardSuccess(id: event.id));
  }
}
