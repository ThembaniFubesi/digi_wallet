part of 'card_bloc.dart';

sealed class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

final class CardInitial extends CardState {}

final class CardLoading extends CardState {}

final class CardLoaded extends CardState {
  final CardEntity card;

  const CardLoaded({required this.card});
}

final class CardFailure extends CardState {
  final String errorMessage;

  const CardFailure({required this.errorMessage});
}
