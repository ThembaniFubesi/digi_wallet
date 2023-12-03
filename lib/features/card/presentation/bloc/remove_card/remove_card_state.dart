part of 'remove_card_bloc.dart';

sealed class RemoveCardState extends Equatable {
  const RemoveCardState();

  @override
  List<Object> get props => [];
}

final class RemoveCardInitial extends RemoveCardState {}

final class RemoveCardLoading extends RemoveCardState {}

final class RemoveCardSuccess extends RemoveCardState {
  final String id;

  const RemoveCardSuccess({required this.id});
}

final class RemoveCardFailure extends RemoveCardState {
  final String errorMessage;

  const RemoveCardFailure({required this.errorMessage});
}
