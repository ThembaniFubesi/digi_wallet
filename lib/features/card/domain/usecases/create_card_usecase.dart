import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/repositories/card_repository.dart';

class CreateCardUseCase {
  final CardRepository repository;

  CreateCardUseCase({required this.repository});

  Future<CardEntity> call(CardEntity card) {
    return repository.create(card);
  }
}
