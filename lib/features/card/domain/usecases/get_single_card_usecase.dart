import 'package:dartz/dartz.dart';
import 'package:digi_wallet/core/error/failure.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/repositories/card_repository.dart';

class GetSingleCardUseCase {
  final CardRepository repository;

  GetSingleCardUseCase({required this.repository});

  Future<Either<Failure, CardEntity>> call(String id) {
    return repository.find(id);
  }
}
