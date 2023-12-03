import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/usecases/update_card_usecase.dart';
import 'package:equatable/equatable.dart';

part 'update_card_event.dart';
part 'update_card_state.dart';

class UpdateCardBloc extends Bloc<UpdateCardEvent, UpdateCardState> {
  final UpdateCardUseCase _updateCardUseCase;
  UpdateCardBloc(this._updateCardUseCase) : super(UpdateCardInitial()) {
    on<UpdateCard>(_updateCard);
  }

  FutureOr<void> _updateCard(
    UpdateCard event,
    Emitter<UpdateCardState> emit,
  ) async {
    emit(UpdateCardLoading());

    final card = await _updateCardUseCase(event.card);

    emit(UpdateCardSuccess(card: card));
  }
}
