part of 'card_list_bloc.dart';

sealed class CardListEvent extends Equatable {
  const CardListEvent();

  @override
  List<Object> get props => [];
}

class LoadCardList extends CardListEvent {}

class AddCard extends CardListEvent {
  final CardEntity payload;

  const AddCard({required this.payload});
}

class UpdateCard extends CardListEvent {
  final CardEntity payload;

  const UpdateCard({required this.payload});
}

class RemoveCard extends CardListEvent {
  final String id;

  const RemoveCard({required this.id});
}
