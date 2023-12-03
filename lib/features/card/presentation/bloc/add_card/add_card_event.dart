part of 'add_card_bloc.dart';

sealed class AddCardEvent extends Equatable {
  const AddCardEvent();

  @override
  List<Object> get props => [];
}

class AddCard extends AddCardEvent {
  final CardEntity payload;

  const AddCard({required this.payload});
}
