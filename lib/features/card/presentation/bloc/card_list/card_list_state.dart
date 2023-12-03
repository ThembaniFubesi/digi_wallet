part of 'card_list_bloc.dart';

enum CardListStatus { initial, loading, loaded, failed }

class CardListState extends Equatable {
  final List<CardEntity> cards;
  final String errorMessage;
  final CardListStatus status;

  const CardListState({
    required this.cards,
    required this.errorMessage,
    required this.status,
  });

  CardListState copyWith({
    List<CardEntity>? cards,
    String? errorMessage,
    CardListStatus? status,
  }) {
    return CardListState(
      cards: cards ?? this.cards,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [cards, errorMessage, status];
}
