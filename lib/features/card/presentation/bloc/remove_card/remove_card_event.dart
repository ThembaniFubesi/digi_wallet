part of 'remove_card_bloc.dart';

sealed class RemoveCardEvent extends Equatable {
  const RemoveCardEvent();

  @override
  List<Object> get props => [];
}

class RemoveCard extends RemoveCardEvent {
  final String id;

  const RemoveCard({required this.id});
}
