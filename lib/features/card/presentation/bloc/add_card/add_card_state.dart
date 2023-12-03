part of 'add_card_bloc.dart';

sealed class AddCardState extends Equatable {
  const AddCardState();

  @override
  List<Object> get props => [];
}

final class AddCardInitial extends AddCardState {}

final class AddCardLoading extends AddCardState {}

final class AddCardSuccess extends AddCardState {
  final CardEntity card;

  const AddCardSuccess({required this.card});
}

final class AddCardFailure extends AddCardState {
  final String errorMessage;

  const AddCardFailure({required this.errorMessage});
}
