part of 'update_card_bloc.dart';

sealed class UpdateCardEvent extends Equatable {
  const UpdateCardEvent();

  @override
  List<Object> get props => [];
}

class UpdateCard extends UpdateCardEvent {
  final CardEntity card;

  const UpdateCard({required this.card});
}
