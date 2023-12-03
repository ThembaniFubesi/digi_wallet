import 'package:digi_wallet/core/database/tables.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:hive/hive.dart';

part 'card_model.g.dart';

@HiveType(typeId: Tables.card)
class CardModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String cardNumber;
  @HiveField(3)
  final int cvv;
  @HiveField(4)
  final String issuingCountry;
  @HiveField(5)
  final String type;

  CardModel({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.cvv,
    required this.issuingCountry,
    required this.type,
  });

  factory CardModel.fromEntity(CardEntity card) => CardModel(
        id: card.id,
        name: card.name,
        cardNumber: card.cardNumber,
        cvv: card.cvv,
        issuingCountry: card.issuingCountry,
        type: card.type,
      );

  CardEntity toEntity() => CardEntity(
        id: id,
        name: name,
        cardNumber: cardNumber,
        cvv: cvv,
        issuingCountry: issuingCountry,
      );
}
