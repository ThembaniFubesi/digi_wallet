import 'package:dartz/dartz.dart';
import 'package:digi_wallet/core/error/failure.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/repositories/card_repository.dart';

class GetCardByCardNumberUseCase {
  final CardRepository repository;

  GetCardByCardNumberUseCase({required this.repository});

  Future<Either<Failure, CardEntity>> call(String cardNumber) {
    return repository.findByCardNumber(cardNumber);
  }
}
