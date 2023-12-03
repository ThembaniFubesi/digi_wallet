part of 'update_card_bloc.dart';

sealed class UpdateCardState extends Equatable {
  const UpdateCardState();

  @override
  List<Object> get props => [];
}

final class UpdateCardInitial extends UpdateCardState {}

final class UpdateCardLoading extends UpdateCardState {}

final class UpdateCardSuccess extends UpdateCardState {
  final CardEntity card;

  const UpdateCardSuccess({required this.card});
}

final class UpdateCardFailure extends UpdateCardState {
  final String errorMessage;

  const UpdateCardFailure({required this.errorMessage});
}
