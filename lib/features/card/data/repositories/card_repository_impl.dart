import 'package:dartz/dartz.dart';
import 'package:digi_wallet/core/error/failure.dart';
import 'package:digi_wallet/features/card/data/datasources/card_local_datasource.dart';
import 'package:digi_wallet/features/card/data/models/card_model.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/domain/repositories/card_repository.dart';

class CardRepositoryImpl implements CardRepository {
  final CardLocalDatasource datasource;

  CardRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<CardEntity>>> all() async {
    try {
      final cardModels = await datasource.all();
      List<CardEntity> response =
          cardModels.map((model) => model.toEntity()).toList();
      return Right(response);
    } catch (error) {
      return Left(DataError(message: error.toString()));
    }
  }

  @override
  Future<CardEntity> create(CardEntity card) async {
    final cardModel = CardModel.fromEntity(card);
    await datasource.create(cardModel);
    return card;
  }

  @override
  Future<Either<Failure, CardEntity>> find(String id) async {
    final cardModel = await datasource.find(id);
    if (cardModel != null) {
      return Right(cardModel.toEntity());
    }
    return Left(DataError(message: 'No card found'));
  }

  @override
  Future<void> remove(String id) async {
    return datasource.remove(id);
  }

  @override
  Future<CardEntity> update(CardEntity card) async {
    final cardModel = CardModel.fromEntity(card);
    await datasource.update(cardModel);
    return card;
  }
}
