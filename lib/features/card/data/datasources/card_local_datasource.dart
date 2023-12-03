import 'package:digi_wallet/features/card/data/models/card_model.dart';
import 'package:hive/hive.dart';

class CardLocalDatasource {
  final Box<CardModel> cardBox;

  CardLocalDatasource({required this.cardBox});

  Future<List<CardModel>> all() async {
    return cardBox.values.toList();
  }

  Future<void> create(CardModel card) async {
    cardBox.put(card.id, card);
  }

  Future<CardModel?> find(String id) async {
    return cardBox.get(id);
  }

  Future<void> update(CardModel card) async {
    if (await find(card.id) != null) {
      cardBox.put(card.id, card);
      return;
    }
  }

  Future<void> remove(String id) async {
    cardBox.delete(id);
  }
}
