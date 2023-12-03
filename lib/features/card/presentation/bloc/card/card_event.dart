part of 'card_bloc.dart';

sealed class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class LoadCard extends CardEvent {
  final String id;

  const LoadCard({required this.id});
}
