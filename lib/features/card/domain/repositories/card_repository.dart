import 'package:dartz/dartz.dart';
import 'package:digi_wallet/core/error/failure.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';

abstract class CardRepository {
  Future<Either<Failure, List<CardEntity>>> all();
  Future<CardEntity> create(CardEntity card);
  Future<Either<Failure, CardEntity>> find(String id);
  Future<CardEntity> update(CardEntity card);
  Future<void> remove(String id);
}
