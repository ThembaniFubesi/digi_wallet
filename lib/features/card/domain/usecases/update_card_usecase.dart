import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/repositories/card_repository.dart';

class UpdateCardUseCase {
  final CardRepository repository;

  UpdateCardUseCase({required this.repository});

  Future<CardEntity> call(CardEntity card) {
    return repository.update(card);
  }
}
