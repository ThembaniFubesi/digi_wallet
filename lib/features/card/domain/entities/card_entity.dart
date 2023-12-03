import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final String id;
  final String name;
  final String cardNumber;
  final int cvv;
  final String issuingCountry;

  String get type {
    return cardNumber.isEmpty ? 'test' : 'test';
  }

  const CardEntity({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.cvv,
    required this.issuingCountry,
  });

  factory CardEntity.fromCardForm({
    required String id,
    required String name,
    required String cardNumber,
    required String cvv,
    required String issuingCountry,
  }) {
    return CardEntity(
      id: id,
      cardNumber: cardNumber,
      cvv: int.parse(cvv),
      issuingCountry: issuingCountry,
      name: name,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        cardNumber,
        cvv,
        issuingCountry,
        type,
      ];
}
