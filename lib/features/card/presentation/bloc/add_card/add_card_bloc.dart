import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/usecases/create_card_usecase.dart';
import 'package:equatable/equatable.dart';

part 'add_card_event.dart';
part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  final CreateCardUseCase _createCardUseCase;

  AddCardBloc(this._createCardUseCase) : super(AddCardInitial()) {
    on<AddCard>(_addCard);
  }

  FutureOr<void> _addCard(
    AddCard event,
    Emitter<AddCardState> emit,
  ) async {
    emit(AddCardLoading());
    final savedCard = await _createCardUseCase(event.payload);
    emit(AddCardSuccess(card: savedCard));
  }
}
