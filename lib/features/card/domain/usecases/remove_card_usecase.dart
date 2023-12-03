import 'package:digi_wallet/features/card/domain/repositories/card_repository.dart';

class RemoveCardUseCase {
  final CardRepository repository;

  RemoveCardUseCase({required this.repository});

  Future<void> call(String id) {
    return repository.remove(id);
  }
}
