import 'package:dartz/dartz.dart';
import 'package:digi_wallet/core/error/failure.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/repositories/card_repository.dart';

class GetCardsUseCase {
  final CardRepository repository;

  GetCardsUseCase({required this.repository});

  Future<Either<Failure, List<CardEntity>>> call() {
    return repository.all();
  }
}
